{
  inputs,
  host,
  kernelData,
  pkgs,
  ...
}:
let
  helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };
  kernelBuild = (pkgs.callPackage ../kernel) {
    inherit
      helpers
      host
      kernelData
      inputs
      ;
  };
  params = import ./lib/kernel-params.nix;
  boot = (import ./lib/boot.nix) {
    efiDisk = "emmc";
    emergencyDisk = "nvme";
  };
  f2fs = import ./lib/f2fs.nix;
  xfs = (import ./lib/xfs.nix);
in
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  fileSystems = {
    inherit (boot) "/boot" "/boot/emergency";
    "/" = {
      device = "/dev/zram1";
      fsType = "ext4";
      neededForBoot = true;
      options = [
        "noatime"
        "x-systemd.device-timeout=0"
      ];
    };

    "/run/media/shared" = f2fs {
      label = "shared";
      neededForBoot = false;
    };

    "/nix" = f2fs {
      label = "store";
      depends = [ "/" ];
    };

    "/nix/persist" = xfs {
      depends = [ "/nix" ];
      device = "/dev/mapper/persist";
      extraOptions = [
        "x-systemd.device-timeout=300"
        "x-systemd.mount-timeout=300"
      ];
    };

    "/nix/persist/cloud" = xfs {
      depends = [ "/nix/persist" ];
      device = "/dev/vg0/cloud";
      extraOptions = [
        "largeio"
        "swalloc"
        "sunit=1024"
        "swidth=4096"
        "inode64"
        "x-systemd.device-timeout=300"
        "x-systemd.mount-timeout=300"
      ];
    };
  };

  swapDevices = [
    {
      device = "/dev/mapper/swapcrypt";
      discardPolicy = "both";
      options = [ "nofail" ];
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  systemd = {
    tmpfiles.rules = [
      "w /sys/block/bcache0/bcache/cache_mode - - - - writethrough"
    ];
    services = {
      lvm-snapshot-weekly = {
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''
            /run/current-system/sw/bin/lvcreate \
              --snapshot --name "snapshot-cloud-$(date +%Y-%m-%d)" \
              vg0/cloud
          '';
        };
      };
    };

    systemd.timers.lvm-snapshot-weekly = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        Unit = "lvm-snapshot-weekly.service";
      };
    };

    boot = {
      resumeDevice = "/dev/mapper/swapcrypt";
      kernelParams = [
        "systemd.gpt_auto=0"
        "rootwait"
        "zram.num_devices=2"
      ]
      ++ params { };
      kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
      swraid = {
        enable = true;
        mdadmConf = ''
          MAILADDR root
          ARRAY /dev/md/raid0 metadata=1.2 spares=1 UUID=00a19bfc:a0b32154:4ed293e4:28565a8f
        '';
      };
      supportedFilesystems = [ "bcachefs" ];
      initrd = {
        availableKernelModules = [ "i915" ];
        kernelModules = [
          "cpufreq_reflex"
          "mmc_block"
          "overlay"
          "md_mod"
          "raid456"
          "btrfs"
          "sdhci_pci"
          "bcache"
          "usb_storage"
          "br_netfilter"
          "uas"
          "uhci_hcd"
          "ehci_hcd"
          "xhci_pci"
          "usbcore"
          "sdhci_acpi"
          "sdhci"
          "tpm-tis"
        ];
        services.lvm.enable = true;
        systemd = {
          storePaths = [
            "${pkgs.btrfs-progs}/bin/btrfs"
            "${pkgs.util-linux}/bin/mount"
            "${pkgs.util-linux}/bin/umount"
            "${pkgs.coreutils}/bin/sleep"
            "${pkgs.systemd}/bin/udevadm"
          ];
          services.setup-storage-stack =
            let
              partlabel = "/dev/disk/by-partlabel";
              idpart = "/dev/disk/by-id";
              keydevice = "${idpart}/usb-Generic_Mass-Storage_20240418000000-0:0-part1";
            in
            {
              wantedBy = [ "initrd.target" ];
              requiredBy = [ "sysroot.mount" ];
              requires = [ "dev-md-raid0.device" ];
              before = [
                "dev-vg0-cloud.device"
                "dev-mapper-persist.device"
                "initrd-fs.target"
                "sysroot.mount"
              ];
              after = [
                "systemd-modules-load.service"
                "dev-md-raid0.device"
              ];
              unitConfig.DefaultDependencies = false;
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };
              path = [
                pkgs.util-linux
                pkgs.bcachefs-tools
                pkgs.cryptsetup
                pkgs.systemd
                pkgs.e2fsprogs
                pkgs.coreutils
                pkgs.lvm2
              ];
              script = ''
                set -e
                mkdir -p /media

                echo 4G > /sys/block/zram1/disksize
                mkfs.ext4 -m 0 -O "^has_journal,^huge_file,^flex_bg" /dev/zram1

                for i in {1..10}; do
                  if [ -e "${keydevice}" ]; then
                      echo "Appear in attempt $i"
                      if mount -t btrfs -o ro,noatime,ssd,discard=async "${keydevice}" /media; then
                          echo "Found key device"
                          break
                      fi
                  fi
                  echo "Waiting key device... ($i/10)"
                  udevadm settle --timeout=2 || true && udevadm trigger --action=add --subsystem-match=block
                  sleep 1
                 done

                 cryptsetup open ${partlabel}/disk-nvme-swapcrypt swapcrypt --key-file /media/secret.key
                 cryptsetup open ${partlabel}/disk-nvme-cloudcachecrypt cloudcachecrypt --key-file /media/secret.key
                 cryptsetup open ${partlabel}/disk-nvme-cloudlogcrypt cloudlogcrypt --key-file /media/secret.key
                 cryptsetup open ${partlabel}/disk-nvme-persist persist --key-file /media/secret.key

                 for i in {1..30}; do
                   if [ -e /dev/bcache0 ]; then
                      echo "Appear in attempt $i"
                      cryptsetup open /dev/bcache0 cloud --key-file /media/secret.key
                      udevadm trigger --action=add --subsystem-match=block
                      udevadm settle
                      lvm vgscan --mknodes
                      lvm vgchange -ay vg0
                      break
                   fi
                   echo "Waiting persist and storage devices... ($i/30)"
                   udevadm settle --timeout=3 || true && udevadm trigger --action=add --subsystem-match=block
                   sleep 1
                  done
              '';
            };
        };
      };
    };
  };
}

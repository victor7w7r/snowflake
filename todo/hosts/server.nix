{
  inputs,
  host,
  config,
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
        "logdev=/dev/mapper/cloudlogcrypt"
        "x-systemd.device-timeout=300"
        "x-systemd.mount-timeout=300"
      ];
    };
  };

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.r8168 ];
    blacklistedKernelModules = [ "r8169" ];
    resumeDevice = "/dev/mapper/swapcrypt";
    kernelParams = [
      "pcie_aspm=off"
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
        "btrfs"
        "br_netfilter"
        "bcache"
        "cryptd"
        "cpufreq_reflex"
        "dm_crypt"
        "mmc_block"
        "nf_nat"
        "md_mod"
        "raid456"
        "ahci"
        "usb_storage"
        "iptable_nat"
        "overlay"
        "uas"
        "uhci_hcd"
        "ehci_hcd"
        "xhci_pci"
        "sdhci_acpi"
        "sdhci"
        "sdhci_pci"
        "tpm-tis"
        "usbcore"
        "zram"
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
            keydevice = "${idpart}/usb-Mass_Storage_Device_121220160204-0:0-part1";
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
}

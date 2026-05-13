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
in
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  fileSystems = {
    inherit (boot) "/boot" "/boot/emergency";
    /*
      "/" = zfs { preDataset = "local"; };
      "/nix" = f2fs {
        label = "store";
        depends = [ "/" ];
      };
      "/nix/persist" = zfs {
        pool = "zpersist";
        dataset = "persist";
        depends = [ "/nix" ];
      };
      "/nix/persist/vm" = zfs {
        pool = "zpersist";
        dataset = "proxmox";
        options = [
          "zfsutil"
          "nofail"
        ];
        depends = [ "/nix/persist" ];
      };
      "/nix/persist/shared" = f2fs {
        label = "shared";
        neededForBoot = false;
        depends = [ "/nix/persist" ];
      };
      "/nix/persist/cloud" = zfs {
        pool = "zcloud";
        dataset = "cloud";
        neededForBoot = false;
        depends = [ "/nix/persist" ];
        };
    */
  };

  swapDevices = [
    {
      device = "/dev/zvol/zswap/local/swap";
      discardPolicy = "both";
      options = [
        "nofail"
        "x-systemd.device-timeout=5s"
      ];
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  boot = {
    kernelParams = [ "resume=/dev/zd0" ] ++ params { };
    kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
    swraid.enable = true;
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
      supportedFilesystems = [ "bcachefs" ];
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
            before = [
              "dev-mapper-persist.device"
              "dev-mapper-storage.device"
              "initrd-fs.target"
              "sysroot.mount"
            ];
            after = [ "systemd-modules-load.service" ];
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

               cryptsetup open ${idpart}/ata-WDC_WD5000LPSX-75A6WT0_WX12A21JEEPK persist --key-file /media/secret.key
               cryptsetup open ${idpart}/ata-ST500LT012-1DG142_S3PMCMHT storage --key-file /media/secret.key
               cryptsetup open ${partlabel}/disk-ssd-swapcrypt swapcrypt --key-file /media/secret.key
               cryptsetup open ${partlabel}/disk-ssd-persistcachecrypt persistcachecrypt --key-file /media/secret.key
               cryptsetup open ${partlabel}/disk-ssd-persistlogcrypt persistlogcrypt --key-file /media/secret.key
               cryptsetup open ${partlabel}/disk-ssd-storagecachecrypt storagecachecrypt --key-file /media/secret.key
               cryptsetup open ${partlabel}/disk-ssd-storagelogcrypt storagelogcrypt --key-file /media/secret.key

               for i in {1..30}; do
                 if [ -e /dev/bcache0 ] && [ -e /dev/bcache1 ] && [ -e /dev/mapper/persist ]  && [ -e /dev/mapper/storage ]; then
                    echo "Appear in attempt $i"
                    udevadm trigger --action=add --subsystem-match=block
                    udevadm settle
                    lvm vgscan --mknodes
                    lvm vgchange -ay vg0
                    lvm vgchange -ay vg1
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

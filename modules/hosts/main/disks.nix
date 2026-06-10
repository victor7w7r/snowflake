{ den, inputs, ... }:
{
  main.disks.nixos =
    let
      partlabel = "/dev/disk/by-partlabel";
      idpart = "/dev/disk/by-id";

      macpartitions = {
        esp = den.aspects.esp.call { };
        macos = {
          name = "macos";
          size = "110G";
          priority = 2;
        };
        root = den.aspects.bcachefs.partition {
          name = "broot.ssd1";
          size = "10G";
          priority = 3;
        };
        shared = den.aspects.btrfs.shared { };
      };

      ssdpartitions = {
        emergency = den.aspects.btrfs.emergency { priority = 1; };
        msr = den.aspects.win.msr { };
        recovery = den.aspects.win.recovery { priority = 3; };
        win = den.aspects.win.call { priority = 4; };
        swapcrypt = den.aspects.luks.call {
          name = "swapcrypt";
          device = "${partlabel}/disk-ssd-swapcrypt";
          size = "64G";
          content = den.aspects.swap.call { };
          priority = 5;
        };
        persistlogcrypt = den.aspects.luks.call {
          name = "persistlogcrypt";
          device = "${partlabel}/disk-ssd-persistlogcrypt";
          size = "512M";
          priority = 6;
        };
        storagelogcrypt = den.aspects.luks.call {
          name = "storagelogcrypt";
          device = "${partlabel}/disk-ssd-storagelogcrypt";
          size = "512M";
          priority = 7;
        };
        persistcachecrypt = den.aspects.luks.call {
          name = "persistcachecrypt";
          device = "${partlabel}/disk-ssd-persistcachecrypt";
          size = "90G";
          priority = 8;
          postCreate = "make-bcache -C /dev/mapper/persistcachecrypt";
        };
        storagecachecrypt = den.aspects.luks.call {
          name = "storagecachecrypt";
          device = "${partlabel}/disk-ssd-storagecachecrypt";
          size = "90G";
          priority = 9;
          postCreate = "make-bcache -C /dev/mapper/storagecachecrypt";
        };
        system = den.aspects.bcachefs.partition {
          filesystem = "bsystem";
          name = "bsystem.ssd1";
          priority = 10;
        };
      };

      lvs0.persist = den.aspects.xfs.call {
        name = "persist";
        size = "85%";
        mountpoint = "/nix/persist";
        logdev = "/dev/mapper/persistlogcrypt";
      };

      lvs1.storage = den.aspects.xfs.call {
        name = "storage";
        size = "85%";
        mountpoint = "/nix/storage";
        logdev = "/dev/mapper/storagelogcrypt";
      };
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];
      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = "/dev/nvme0n1";
            content = {
              type = "gpt";
              partitions = macpartitions;
            };
          };

          ssd = {
            type = "disk";
            device = "${idpart}/ata-Micron_2400_MTFDKBK512QFM_232240F15D36";
            content = {
              type = "gpt";
              partitions = ssdpartitions;
            };
          };

          persist = {
            type = "disk";
            device = "${idpart}/ata-WDC_WD5000LPSX-75A6WT0_WX12A21JEEPK";
            content = {
              entireDisk = true;
              allowDiscards = false;
              name = "persist";
              size = "100%";
              device = "${idpart}/ata-WDC_WD5000LPSX-75A6WT0_WX12A21JEEPK";
              postMount = ''
                cryptsetup open ${partlabel}/disk-ssd-persistcachecrypt persistcachecrypt --key-file /tmp/key.txt || true
                cryptsetup open ${partlabel}/disk-ssd-persistlogcrypt persistlogcrypt --key-file /tmp/key.txt || true
                echo /dev/mapper/persist | tee /sys/fs/bcache/register || true
              '';
              postCreate = ''
                make-bcache -B /dev/mapper/persist
                #CACHE_SET_UUID=$(sudo bcache-super-show /dev/disk/by-id/ata-Micron_2400_MTFDKBK512QFM_232240F15D36-part8 | grep 'cset.uuid' | awk '{print $2}')
                #echo $CACHE_SET_UUID > /sys/block/bcache0/bcache/attach
              '';
            };
          };

          storage = {
            type = "disk";
            device = "${idpart}/ata-ST500LT012-1DG142_S3PMCMHT";
            content = den.aspects.luks.call {
              entireDisk = true;
              allowDiscards = false;
              name = "storage";
              device = "${idpart}/ata-ST500LT012-1DG142_S3PMCMHT";
              size = "100%";
              postMount = ''
                cryptsetup open ${partlabel}/disk-ssd-storagecachecrypt storagecachecrypt --key-file /tmp/key.txt || true
                cryptsetup open ${partlabel}/disk-ssd-storagelogcrypt storagelogcrypt --key-file /tmp/key.txt || true
                echo /dev/mapper/persist | tee /sys/fs/bcache/register || true
              '';
              postCreate = ''
                make-bcache -B /dev/mapper/storage
                #CACHE_SET_UUID=$(sudo bcache-super-show /dev/disk/by-id/ata-Micron_2400_MTFDKBK512QFM_232240F15D36-part9 | grep 'cset.uuid' | awk '{print $2}')
                #echo $CACHE_SET_UUID > /sys/block/bcache1/bcache/attach
              '';
            };
          };

          bcache0 = {
            type = "disk";
            device = "/dev/bcache0";
            content = {
              vg = "vg0";
              type = "lvm_pv";
            };
          };

          bcache1 = {
            type = "disk";
            device = "/dev/bcache1";
            content = {
              vg = "vg1";
              type = "lvm_pv";
            };
          };
        };

        lvm_vg = {
          "vg0" = {
            type = "lvm_vg";
            lvs = lvs0;
          };
          "vg1" = {
            type = "lvm_vg";
            lvs = lvs1;
          };
        };

        bcachefs_filesystems = {
          bsystem = den.aspects.bcachefs.filesystem {
            uuid = "66684a8a-b6ef-45ac-9e24-9ee3a2b4b540";
            subvolumes = {
              "subvolumes/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "nodiratime"
                  "noatime"
                  "discard"
                  "fsck"
                ];
              };
              "subvolumes/etc" = {
                mountpoint = "/nix/persist/etc";
                mountOptions = [
                  "nodiratime"
                  "noatime"
                  "discard"
                  "fsck"
                ];
              };
            };
          };

          broot = den.aspects.bcachefs.filesystem {
            mountpoint = "/";
            subvolumes = { };
            uuid = "f9d26816-07f4-42cf-a9ae-f698ff56b172";
          };
        };
      };
    };
}

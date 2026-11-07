/*
  { inputs, disko, ... }:
  {
    den.aspects =
      with disko;
      let
        main = disk.gpt {
          device = "nvme0n1";
          partitions = {
            esp = esp.call { };
            msr = win.msr { };
            recovery = win.recovery { priority = 3; };
            macos = {
              name = "macos";
              size = "250G";
              priority = 4;
            };
            win = win.call {
              priority = 5;
              size = "100%";
            };
          };
        };

        zmini = {
          vdev = [ { members = [ "${idpart}/ata-Micron_2400_MTFDKBK512QFM_232240F15D36" ]; } ];
          datasets =
            zfs.preDataset { }
            // (zfs.volume {
              name = "swap";
              size = "64G";
              options = {
                compression = "zle";
                logbias = "throughput";
                encryption = "aes-256-gcm";
                keyformat = "passphrase";
                keylocation = "file:///tmp/secret.key";
                primarycache = "metadata";
                secondarycache = "none";
              };
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            })
            // (zfs.dataset {
              pool = "zmini";
              name = "persist";
              mountpoint = "/nix/persist";
              options = {
                compression = "zstd";
                encryption = "aes-256-gcm";
                keyformat = "passphrase";
                keylocation = "file:///tmp/secret.key";
                "com.sun:auto-snapshot" = "true";
              };
            });
        };

        zstorage = {
          vdev = [ { members = [ "${idpart}/ata-ST500LT012-1DG142_S3PMCMHT" ]; } ];
          datasets =
            zfs.preDataset { }
            // zfs.dataset {
              pool = "zstorage";
              name = "storage";
              mountpoint = "/nix/persist/storage";
              options = {
                encryption = "aes-256-gcm";
                keyformat = "passphrase";
                keylocation = "file:///tmp/secret.key";
                "com.sun:auto-snapshot" = "true";
              };
            };
        };

        zssd = zfs.pool {
          vdev = [ { members = [ "${idpart}/ata-Dahua_C800_2.5_inch_SATA_256GB_SSD_N9YM01A00A03658" ]; } ];
          datasets =
            zfs.preDataset { }
            // zfs.dataset {
              pool = "zssd";
              name = "store";
              mountpoint = "/nix/store";
              options = {
                canmount = "on";
                compression = "zstd";
                "com.sun:auto-snapshot" = "true";
              };
            };
        };
      in
      {
        main.disks.nixos = {
          imports = [ inputs.disko.nixosModules.disko ];
          fileSystems = {
            "/nix/persist".neededForBoot = true;
            "/etc".neededForBoot = true;
          };
                disko.devices = {
            disk = {
              inherit main;
              root = disk.root { };
              mini-nvme = zfs.entireDisk {
                device = "ata-Micron_2400_MTFDKBK512QFM_232240F15D36";
              };
              storage = zfs.entireDisk {
                device = "ata-ST500LT012-1DG142_S3PMCMHT";
              };
              ssd = zfs.entireDisk {
                device = "ata-Dahua_C800_2.5_inch_SATA_256GB_SSD_N9YM01A00A03658";
              };
            };

            zpool = { inherit zmini zstorage zssd; };
          };
        };

        main-chroot.nixos = {
          imports = [ inputs.disko.nixosModules.disko ];
          disko.devices = {
            disk = {
              inherit main;
              mini-nvme = zfs.entireDisk {
                device = "ata-Micron_2400_MTFDKBK512QFM_232240F15D36";
              };
              storage = zfs.entireDisk {
                device = "ata-ST500LT012-1DG142_S3PMCMHT";
              };
              ssd = zfs.entireDisk {
                device = "ata-Dahua_C800_2.5_inch_SATA_256GB_SSD_N9YM01A00A03658";
              };
            };

            zpool = { inherit zmini zstorage zssd; };
          };
        };
      };
  }
*/

{ inputs, disko, ... }:
{
  den.aspects =
    with disko;
    let
      main = disk.gpt {
        device = "nvme0n1";
        partitions = {
          esp = esp.call { };
          macos = {
            name = "macos";
            size = "110G";
            priority = 2;
          };
          system = btrfs.call {
            name = "system";
            size = "200G";
            subvolumes = btrfs.subvolumes {
              hasEtc = true;
              hasPersist = false;
            };
          };
          shared = btrfs.shared { };
        };
      };
      ssd =
        {
          extraParts ? { },
        }:
        disk.gpt {
          device = "${disk.constants.id}/ata-Micron_2400_MTFDKBK512QFM_232240F15D36";
          partitions = {
            emergency = btrfs.emergency { priority = 1; };
            msr = win.msr { };
            recovery = win.recovery { priority = 3; };
            win = win.call { priority = 4; };
            # shared = btrfs.shared { name = "ssdshared"; };
          }
          // extraParts;
        };
      lvm_vg =
        (xfs.lvm {
          name = "persist";
          size = "85%";
          mountpoint = "/nix/persist";
        })
        // (xfs.lvm {
          num = 1;
          name = "storage";
          size = "85%";
          mountpoint = "/nix/persist/storage";
        });
    in
    {
      main.disks.nixos = {
        imports = [ inputs.disko.nixosModules.disko ];
        fileSystems = {
          "/nix/persist".neededForBoot = true;
          "/etc".neededForBoot = true;
        };
        boot.resumeDevice = "/dev/mapper/swapcrypt";
        swapDevices = [
          {
            device = "/dev/mapper/swapcrypt";
            discardPolicy = "both";
            options = [ "nofail" ];
          }
        ];
        disko.devices = {
          inherit lvm_vg;
          disk = {
            bcache0 = disk.bcache { };
            inherit main;
            ssd = ssd { };
            root = disk.root { };
          };
        };
      };

      main-chroot.nixos = {
        imports = [ inputs.disko.nixosModules.disko ];
        disko.devices = {
          inherit lvm_vg;
          disk = {
            inherit main;
            bcache0 = disk.bcache { };
            ssd = ssd {
              extraParts = {
                swapcrypt = luks.call {
                  name = "swapcrypt";
                  device = "${disk.constants.partlabel}/disk-ssd-swapcrypt";
                  size = "64G";
                  content = swap.call { };
                  priority = 5;
                };
                persistcachecrypt = luks.call {
                  name = "persistcachecrypt";
                  device = "${disk.constants.partlabel}/disk-ssd-persistcachecrypt";
                  size = "120G";
                  priority = 6;
                  postCreate = "make-bcache -C /dev/mapper/persistcachecrypt";
                };
              };
            };
            storage = luks.entire {
              name = "storage";
              device = "/dev/${disk.constants.id}/ata-ST500LT012-1DG142_S3PMCMHT";
            };
            persist = luks.entire {
              name = "persist";
              device = "/dev/${disk.constants.id}/ata-WDC_WD5000LPSX-75A6WT0_WX12A21JEEPK";
              postCreate = "make-bcache -B /dev/mapper/persist";
            };
          };
        };
      };
    };
}

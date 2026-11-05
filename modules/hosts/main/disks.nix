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
        #boot.resumeDevice = "/dev/mapper/swapcrypt";
        /*
          swapDevices = [
            {
              device = "/dev/mapper/swapcrypt";
              discardPolicy = "both";
              options = [ "nofail" ];
            }
          ];
        */
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

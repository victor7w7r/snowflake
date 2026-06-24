{ disko, inputs, ... }:
{
  generic.disks.nixos =
    let
      partitions = {
        esp = disko.esp.call { };
        emergency = disko.btrfs.emergency { isSolid = false; };
        system = disko.bcachefs.partition {
          name = "system";
          size = "90G";
        };
      };
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];

      fileSystems."/" = {
        device = "/dev/zram1";
        fsType = "ext4";
        neededForBoot = true;
        options = [
          "noatime"
          "x-systemd.device-timeout=0"
        ];
      };

      disko.devices = {
        disk.main = {
          type = "disk";
          device = "/dev/vda";
          content = {
            type = "gpt";
            inherit partitions;
          };
        };
        bcachefs_filesystems = {
          broot = disko.bcachefs.filesystem {
            subvolumes = {
              "subvolumes/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "nodiratime"
                  "noatime"
                  "discard"
                ];
              };
              "subvolumes/persist" = {
                mountpoint = "/nix/persist";
                mountOptions = [
                  "nodiratime"
                  "noatime"
                  "discard"
                ];
              };
            };
          };
        };
      };
    };
}

{ den, inputs, ... }:
{
  handheld.disks.nixos =
    let
      partitions = {
        esp = den.aspects.esp.call { };
        msr = den.aspects.win.msr { };
        emergency = den.aspects.btrfs.emergency { priority = 3; };
        recovery = den.aspects.win.recovery { };
        win = den.aspects.win.call { };
        swapcrypt = den.aspects.luks.call {
          name = "swapcrypt";
          size = "14G";
          group = "main";
          content = den.aspects.swap.call { };
          priority = 6;
        };
        system = den.aspects.bcachefs.partition {
          name = "system";
          size = "110G";
          priority = 7;
        };
        games = den.aspects.btrfs.shared {
          name = "games";
          mountContent = "games";
          mountSnap = "gamessnap";
        };
      };
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];
      disko.devices = {
        disk.main = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            inherit partitions;
          };
        };
        bcachefs_filesystems = {
          broot = den.aspects.bcachefs.filesystem {
            uuid = "2564fcf6-551f-4358-b238-2fe638b1c159";
            #passwordFile = "/tmp/key.txt";
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

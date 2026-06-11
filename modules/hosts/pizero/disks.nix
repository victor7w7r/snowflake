{ disko, inputs, ... }:
{
  generic.disks.nixos =
    let
      diskpartitions.store = disko.xfs.call {
        name = "store";
        size = "100%";
        mountpoint = "/nix";
        priority = 1;
      };
      sdpartitions = {
        boot = disko.esp.call { size = "96M"; };
        persist = disko.f2fs.call {
          name = "persist";
          size = "100%";
          mountpoint = "/nix/persist";
          priority = 2;
        };
      };
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];

      /*
        fileSystems = {
        "/" = {
          device = "none";
          fsType = "tmpfs";
          options = [
            "defaults"
            "size=2G"
            "mode=755"
          ];
        };
        "/boot" = {
          device = "/dev/disk/by-label/BOOT";
          fsType = "vfat";
          options = [
            "nofail"
            "noauto"
          ];
        };
        "/nix" = {
          device = "/dev/disk/by-label/store";
          neededForBoot = true;
          fsType = "xfs";
          options = [
            "noatime"
            "nodiratime"
            "lazytime"
            "logbufs=8"
            "logbsize=256k"
          ];
        };
        "/nix/persist" = f2fs {
          label = "persist";
          device = "/dev/disk/by-label/persist";
          depends = [ "/nix" ];
        };
        };
      */

      fileSystems."/" = {
        device = "/dev/zram1";
        fsType = "ext4";
        neededForBoot = true;
        options = [
          "noatime"
          "x-systemd.device-timeout=0"
        ];
      };

      disko.devices.disk = {
        storedisk = {
          type = "disk";
          device = "/dev/sda";
          content = {
            type = "gpt";
            inherit diskpartitions;
          };
          sdcard = {
            type = "disk";
            device = "/dev/mmcblk0";
            content = {
              type = "dos";
              inherit sdpartitions;
            };
          };
        };
      };
    };
}

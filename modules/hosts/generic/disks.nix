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
      disko.devices.disk.main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          inherit partitions;
        };
      };
    };
}

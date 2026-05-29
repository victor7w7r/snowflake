{ den, inputs, ... }:
{
  generic.disks.nixos =
    { ... }:
    let
      partitions = {
        esp = den.aspects.esp.call { };
        emergency = den.aspects.btrfs.emergency { isSolid = false; };
        system = den.aspects.bcachefs.partition {
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

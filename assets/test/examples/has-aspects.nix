{ den, ... }:
{
  den.aspects.example-zfs-root.nixos = {
    environment.etc."example-root-backend".text = "zfs";
  };

  den.aspects.example-btrfs-root.nixos = {
    environment.etc."example-root-backend".text = "btrfs";
  };

  den.aspects.example-impermanence =
    { host, ... }:
    {
      nixos =
        { lib, ... }:
        lib.mkMerge [
          (lib.mkIf (host.hasAspect den.aspects.example-zfs-root) {
            environment.etc."example-impermanence-flavor".text = "zfs";
          })
          (lib.mkIf (host.hasAspect den.aspects.example-btrfs-root) {
            environment.etc."example-impermanence-flavor".text = "btrfs";
          })
        ];
    };

}

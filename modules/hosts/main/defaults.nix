{ main, ... }:
{
  den = {
    hosts.x86_64-linux.main.users.victor7w7r = { };

    aspects.main = {
      includes = [
        main.disks
      ];
      #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
      nixos = {
      };

      homeManager =
        { config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "storage".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/storage";
          };
        };
    };
  };
}

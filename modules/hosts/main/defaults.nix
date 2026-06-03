{ inputs, main, ... }:
{
  imports = [ (inputs.den.namespace "main" false) ];

  den = {
    hosts.x86_64-linux.main = {
      hostName = "v7w7r-macmini81";
      users.victor7w7r = { };
    };

    aspects.main = {
      includes = [
        main.disks
      ];
      #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
      nixos = {
        services.hardware.bolt.enable = true;
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

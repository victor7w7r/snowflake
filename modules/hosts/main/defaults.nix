{ inputs, main, ... }:
{
  imports = [ (inputs.den.namespace "main" false) ];
  #nixos-hardware.nixosModules.apple-t2

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
        swapDevices = [
          {
            device = "/dev/mapper/swapcrypt";
            discardPolicy = "both";
            options = [ "nofail" ];
          }
        ];

        systemd.tmpfiles.rules = [
          "w /sys/block/bcache0/bcache/cache_mode - - - - writethrough"
          "w /sys/block/bcache1/bcache/cache_mode - - - - writethrough"
        ];
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

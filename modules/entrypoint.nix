{ den, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };

  /*
    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.pcscd.enable = true;
  */

  den = {
    schema.user = {
      includes = [ den.batteries.mutual-provider ];
      classes = lib.mkDefault [ "homeManager" ];
    };
    default = {
      darwin.system.stateVersion = 6;
      nixos.system.stateVersion = "26.05";
      homeManager = {
        home.stateVersion = "26.05";
        language.base = "es_ES.UTF-8";
      };
      includes = [
        den.batteries.hostname
        den.batteries.define-user
        den.batteries.primary-user
        den.batteries.hostname
        den.batteries.inputs'
        den.batteries.self'
      ];

      provides.to-hosts = {
        nixos =
          { inputs', pkgs, ... }:
          {
            imports = [ inputs'.home-manager.nixosModules.home-manager ];
            home-manager = {
              backupCommand = "${pkgs.trash-cli}/bin/trash";
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
            };
          };

        homeManager =
          { config, ... }:
          {
            home.file."repositories/nixstrap".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
          };
      };
    };
  };
}

{ den, lib, ... }:
{
  #imports = [ (inputs.den.namespace "hosts-attrs" true) ];
  perSystem =
    { pkgs, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
    };

  /*
    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.pcscd.enable = true;
  */

  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den = {
    schema.user.classes = lib.mkDefault [ "homeManager" ];
    default = {
      darwin.system.stateVersion = 6;
      nixos.system.stateVersion = "25.05";
      homeManager.home.stateVersion = "25.05";
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
          { inputs, pkgs, ... }:
          {
            imports = [ inputs.home-manager.nixosModules.home-manager ];
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
            home.file = {
              "repositories/nixstrap".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
            };
          };
      };
    };
  };
}

{
  conf,
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flakehub.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.default =
    let
      stateVersion = "26.05";
    in
    {
      os.nixpkgs.config.allowUnfree = true;
      nixos = {
        system.stateVersion = stateVersion;
        nix.settings = conf.lib.flake-config // conf.lib.nix-config;
        programs.nix-ld.enable = true;
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          man.enable = false;
        };
        #package = lib.mkDefault (pkgs.lix);
      };

      provides.to-users.homeManager = {
        home = {
          stateVersion = stateVersion;
          language.base = "es_ES.UTF-8";
        };
        manual = {
          html.enable = lib.mkDefault false;
          json.enable = lib.mkDefault false;
          manpages.enable = lib.mkDefault false;
        };
      };

      darwin = {
        imports = [ inputs.determinate.darwinModules.default ];
        system = {
          checks.verifyBuildUsers = false;
          stateVersion = 6;
        };
        nix = {
          enable = lib.mkForce false;
          nixPath = lib.mkDefault [ ];
          optimise.automatic = lib.mkDefault false;
        };
        determinateNix.customSettings = {
          flake-registry = "/etc/nix/flake-registry.json";
          sandbox = "relaxed";
        }
        // conf.lib.flake-config
        // conf.lib.nix-config;
      };
    };
}

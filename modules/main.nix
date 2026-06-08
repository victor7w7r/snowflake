{ lib, conf, ... }:
{
  den.default = {
    nixos = {
      system.stateVersion = "26.05";
      nix.settings = conf.lib.flake-config // conf.lib.nix-config;
      nixpkgs.config.allowUnfree = true;
      programs.nix-ld.enable = true;
      #package = lib.mkDefault (pkgs.lix);
    };
    homeManager = {
      home.stateVersion = "26.05";
      language.base = "es_ES.UTF-8";
      manual = {
        html.enable = lib.mkDefault false;
        json.enable = lib.mkDefault false;
        manpages.enable = lib.mkDefault false;
      };
    };
    darwin =
      { inputs', ... }:
      {
        imports = [ inputs'.determinate.darwinModules.default ];

        system = {
          checks.verifyBuildUsers = false;
          stateVersion = 6;
        };
        nixpkgs.config.allowUnfree = true;
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

{
  den,
  inputs,
  withSystem,
  ...
}:
{
  flake-file.inputs = {
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:/nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };

  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
    inputs.flake-file.flakeModules.default
  ];

  perSystem =
    { pkgs, system, ... }:
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
      pkgsDirectory = ../../pkgs/by-name;
      pkgsNameSeparator = "-";
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          #inputs.deploy-rs.overlays.default
          (final: _prev: {
            master = import inputs.nixpkgs-master {
              inherit (final) config;
              inherit system;
            };
          })
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              inherit system;
            };
          })
        ];
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = false;
        };
      };
    };
  flake = {
    overlays.default =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { config, ... }:
        {
          local = config.packages;
        }
      );
  };
}

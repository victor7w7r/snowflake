{ inputs, withSystem, ... }:
{
  flake-file.inputs.pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  imports = [ inputs.pkgs-by-name-for-flake-parts.flakeModule ];

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        pkgsDirectory = ./by-name;
        pkgsNameSeparator = "-";
        overlays = [ inputs.deploy-rs.overlays.default ];
        config = {
          cudaSupport = true;
          allowUnfree = true;
          allowUnsupportedSystem = false;
        };
      };
    };

  flake.overlays.default =
    _: prev:
    withSystem prev.stdenv.hostPlatform.system (
      { config, ... }:
      {
        local = config.packages;
      }
    );
}

{
  inputs,
  withSystem,
  ...
}:
{
  flake-file.inputs.pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  imports = [ inputs.pkgs-by-name-for-flake-parts.flakeModule ];

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        pkgsDirectory = ../pkgs/by-name;
        pkgsNameSeparator = "-";
        config = {
          cudaSupport = true;
          allowUnfree = true;
          allowUnsupportedSystem = false;
        };
        overlays = [
          inputs.deploy-rs.overlays.default
          # inputs.emacs-config.overlays.default
          # inputs.agenix.overlays.default
        ];
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

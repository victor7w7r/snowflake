{
  den,
  inputs,
  withSystem,
  kernel,
  ...
}:
{
  flake-file.inputs = {
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:/nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    xrlinux = {
      url = "github:wheaney/XRLinuxDriver";
      flake = false;
    };
  };

  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
    inputs.flake-file.flakeModules.default
  ];

  perSystem =
    { pkgs, system, ... }:
    let
      handheld = (kernel.hosts.handheld pkgs);
      main = (kernel.hosts.main pkgs);
      server = (kernel.hosts.server pkgs);
      pizero = (kernel.hosts.pizero pkgs);
      main-kernel = main.main-kernel;
    in
    {
      packages = den.lib.nh.denPackages { fromFlake = true; } pkgs // {
        inherit main-kernel;
        main-config = main.main-config;
        handheld-kernel = handheld.handheld-kernel;
        handheld-config = handheld.handheld-config;
        server-kernel = server.server-kernel;
        server-config = server.server-config;
        pizero-kernel = pizero.pizero-kernel;
        pizero-config = pizero.pizero-config;
      };
      pkgsDirectory = ../../pkgs/by-name;
      pkgsNameSeparator = "-";
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          #inputs.deploy-rs.overlays.default
          (final: _: {
            master = import inputs.nixpkgs-master {
              inherit (final) config;
              inherit system;
            };
          })
          (final: _: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              inherit system;
            };
          })
          (final: _: {
            inherit main-kernel;
          })
        ];
        config = {
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

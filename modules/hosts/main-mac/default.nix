{
  inputs,
  lib,
  settings,
  __findFile,
  ...
}:
{
  flake-file.inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    flakehub.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
  };

  imports = [ (inputs.den.namespace "main-mac" false) ];

  den = {
    hosts.x86_64-darwin.main-mac = {
      hostName = "v7w7r-macmini81";
      users.victor7w7r = { };
    };

    default.darwin =
      {
        inputs',
        pkgs,
        user,
        ...
      }:
      {
        system.primaryUser = user;
        time.timeZone = "America/Guayaquil";

        #determinateNix = determinate.inputs.nix.packages."x86_64-darwin".default;

        environment.defaultPackages = with pkgs; [
          coreutils-full
          findutils
          gnugrep
          gnused
          hyperfine
          moreutils
          readline
          watch
          xxh
          x-cmd
          fd
          fpp
          fsql
          rm-improved
          mprocs
          m-cli
          cocoapods
          colima
          lima
          tailscale
        ];

        imports = [ inputs'.determinate.darwinModules.default ];
        system = {
          checks.verifyBuildUsers = false;
          stateVersion = 6;
        };
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          man.enable = false;
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
        // settings.lib.flake-config
        // settings.lib.nix-config;
      };

    # sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake .#macmini
    aspects.main-mac = {
      includes = [
        <kitty>
        <starship>
      ];
    };
  };
}

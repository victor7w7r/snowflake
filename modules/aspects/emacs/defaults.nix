{ lib, ... }:
{
  flake-file.inputs = {
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };
  };

  den.aspects.emacs = {
    nixos =
      {
        inputs',
        isPersistent,
        pkgs,
        user,
        ...
      }:
      {
        nixpkgs.overlays = [
          inputs'.emacs-overlay.overlay
          inputs'.emacs-config.overlays.default
        ];
        environment = lib.mkMerge [
          (lib.mkIf isPersistent {
            persistence."/nix/persist".users."${user}".directories = lib.mkAfter [
              ".local/share/emacs"
              ".cache/doom"
            ];
          })
          {
            systemPackages = with pkgs; [ emacs-nox ];
          }
        ];
      };

    homeManager =
      {
        config,
        inputs',
        pkgs,
        ...
      }:
      {
        imports = [ inputs'.nix-doom-emacs-unstraightened.homeModule ];
        programs.doom-emacs = {
          enable = false;
          emacs = pkgs.emacs-nox;
          doomDir = ./.;
          doomLocalDir = "${config.home.homeDirectory}/.local/share/emacs";
          extraPackages = epkgs: with epkgs; [ melpaPackages.nixos-options ];
          extraBinPackages = with pkgs; [
            git
            ripgrep
            fd
          ];
        };
      };
  };
}

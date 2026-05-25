{
  config,
  inputs,
  pkgs,
  ...
}:
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

    nixos = {
      environment.systemPackages = with pkgs; [ emacs-nox ];
      nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    };

    homeManager = {
      imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];
      programs.doom-emacs = {
        enable = false;
        emacs = pkgs.emacs-nox;
        doomDir = ./.;
        doomLocalDir = "${config.home.homeDirectory}/.local/share/emacs";
        extraPackages =
          epkgs: with epkgs; [
            melpaPackages.nixos-options
          ];
        extraBinPackages = with pkgs; [
          git
          ripgrep
          fd
        ];
      };
    };
  };
}

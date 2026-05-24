{ config, pkgs, ... }:
{
  den.aspects.emacs.nixos.programs.doom-emacs = {
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
}

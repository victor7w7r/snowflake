{ inputs, self, ... }:
{
  flake-file.inputs.nix-doom-emacs-unstraightened = {
    url = "github:marienz/nix-doom-emacs-unstraightened";
    inputs.nixpkgs.follows = "";
  };

  den.aspects.emacs =
    { user, ... }:
    {
      nixos =
        { isPersistent, lib, ... }:
        {
          environment.persistence."/nix/persist".users."${user.name}".directories =
            lib.optionals isPersistent
              [
                ".config/emacs"
                ".cache/doom"
              ];
        };

      provides.to-users.homeManager =
        { config, pkgs, ... }:
        {
          imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];
          programs.doom-emacs = {
            enable = true;
            emacs = pkgs.emacs-nox;
            doomDir = "${self}/modules/aspects/emacs";
            doomLocalDir = "${config.home.homeDirectory}/.config/emacs";
            extraBinPackages = with pkgs; [
              git
              ripgrep
              fd
            ];
            extraPackages =
              epkgs: with epkgs; [
              /*  annotate
                auto-rename-tag
                beacon
                blackjack
                bm
                buffer-move
                clippy
                colorful-mode
                copilot
                copilot-chat
                evil-matchit
                evil-tutor
                fancy-compilation
                fireplace
                gameoflife
                helm-system-packages
                hungry-delete
                klondike
                mentor
                move-text
                multi-vterm
                mwim
                nyan-mode
                pacmacs
                parrot
                pkg-info
                rainbow-delimiters
                speed-type
                string-inflection
                sudoku
                svelte-mode
                tagedit
                tldr
                toggle-quotes
                versuri
                visual-regexp
                which-key*/
                treesit-grammars.with-all-grammars
              ];
          };
        };
    };
}

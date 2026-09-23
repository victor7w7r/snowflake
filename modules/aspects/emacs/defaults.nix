{ inputs, self, ... }:
{
  flake-file.inputs.nix-doom-emacs-unstraightened = {
    url = "github:marienz/nix-doom-emacs-unstraightened";
    inputs.nixpkgs.follows = "";
  };

  den.aspects.emacs =
    { user, ... }:
    {
      nixos.environment.persistence."/nix/persist".users."${user.name}".directories = [
        ".config/emacs"
        ".cache/doom"
      ];

      provides.to-users.homeManager =
        { config, pkgs, ... }:
        {
          imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];
          programs.doom-emacs = {
            enable = true;
            emacs = pkgs.emacs;
            doomDir = "${self}/modules/aspects/emacs";
            doomLocalDir = "${config.home.homeDirectory}/.config/emacs";
            extraBinPackages = with pkgs; [
              cmake
              direnv
              dockfmt
              gcc
              gnumake
              nixfmt
              shfmt
              wl-clipboard-rs
            ];
            extraPackages =
              epkgs: with epkgs; [
                annotate
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
                which-key
                (treesit-grammars.with-grammars (
                  gs: with gs; [
                    tree-sitter-astro
                    tree-sitter-bash
                    tree-sitter-css
                    tree-sitter-dockerfile
                    tree-sitter-elisp
                    tree-sitter-git-config
                    tree-sitter-git-rebase
                    tree-sitter-gitattributes
                    tree-sitter-gitcommit
                    tree-sitter-gitignore
                    tree-sitter-html
                    tree-sitter-ini
                    tree-sitter-javascript
                    tree-sitter-json
                    tree-sitter-kotlin
                    tree-sitter-nix
                    tree-sitter-rust
                    tree-sitter-sql
                    tree-sitter-sshclientconfig
                    tree-sitter-svelte
                    tree-sitter-toml
                    tree-sitter-tsx
                    tree-sitter-typescript
                    tree-sitter-vue
                    tree-sitter-xml
                    tree-sitter-yaml
                  ]
                ))
              ];
          };
        };
    };
}

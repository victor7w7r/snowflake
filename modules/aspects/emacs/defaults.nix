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
        ".local/share/doom"
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
              black
              biome
              cmake
              direnv
              dockfmt
              gcc
              gnumake
              html-tidy
              js-beautify
              libclang
              libxml2
              nixfmt
              nixd
              pipenv
              poetry
              rustfmt
              shfmt
              shellcheck
              stylelint
              wl-clipboard-rs
            ];
            extraPackages =
              epkgs: with epkgs; [
                auto-rename-tag
                astro-ts-mode
                beacon
                blackjack
                bm
                buffer-move
                clippy
                colorful-mode
                copilot
                copilot-chat
                drag-stuff
                emojify
                emojify-logos
                evil-escape
                evil-matchit
                evil-tutor
                fancy-compilation
                flymake-ktlint
                flymake-shellcheck
                fireplace
                gameoflife
                hungry-delete
                klondike
                mentor
                multi-vterm
                pacmacs
                pkg-info
                rainbow-delimiters
                speed-type
                string-inflection
                sudoku
                super-save
                svelte-mode
                symbol-overlay
                tagedit
                tldr
                typescript-mode
                toggle-quotes
                visual-regexp
                vue-mode
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

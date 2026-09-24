{
  den.default.os = { pkgs, ... }: {
    programs.nixvim.plugins = {
      bullets.enable = true;
      crates.enable = true;
      lsp-signature.enable = true;
      markdown-preview.enable = true;
      typescript-tools.enable = true;

      package-info = {
        enable = true;
        lazyLoad.settings.event = [ "BufRead package.json" ];
        settings.hide_up_to_date = true;
      };

      lsp = {
        enable = true;
        servers = {
          astro.enable = true;
          bashls.enable = true;
          biome.enable = true;
          cssls.enable = true;
          custom_elements_ls = {
            enable = true;
            package = null;
          };
          docker_compose_language_service.enable = true;
          dockerls.enable = true;
          emmet_ls.enable = true;
          html.enable = true;
          gradle_ls = {
            enable = true;
            package = null;
          };
          jsonls.enable = true;
          kotlin_lsp = {
            enable = true;
            package = null;
          };
          marksman.enable = true;
          oxfmt.enable = true;
          oxlint.enable = true;
          nixd = {
            enable = true;
            settings = {
              nixpkgs = {
                expr = "import <nixpkgs> { }";
              };
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };
          pylsp.enable = true;
          ts_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          sqls.enable = true;
          stylelint_lsp.enable = true;
          svelte.enable = true;
          unocss = {
            enable = true;
            package = null;
          };
          vue_ls.enable = true;
          yamlls.enable = true;
        };
        keymaps.diagnostic = {
          "<leader>dl" = "open_float";
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };
      };

      treesitter = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings.event = "BufRead";
        };
        settings = {
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          astro
          bash
          css
          diff
          dockerfile
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          html
          html
          ini
          javascript
          json
          kotlin
          markdown
          nix
          python
          query
          regex
          rust
          sql
          ssh_config
          svelte
          tsx
          typescript
          vue
          xml
          yaml
          zsh
        ];
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            css = [ "oxfmt" ];
            html = [ "oxfmt" ];
            javascript = [ "oxfmt" ];
            javascriptreact = [ "oxfmt" ];
            json = [ "oxfmt" ];
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
            sh = [ "shfmt" ];
            typescript = [ "oxfmt" ];
            typescriptreact = [ "oxfmt" ];
            vue = [ "oxfmt" ];
          };
          default_format_opts = {
            timeout_ms = 3000;
            lsp_format = "fallback";
          };
          format_on_save = {
            __raw = ''
              function(bufnr)
                if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
                  return
                end
                return { timeout_ms = 3000, lsp_format = "fallback" }
              end
            '';
          };
        };
      };
    };
  };
}

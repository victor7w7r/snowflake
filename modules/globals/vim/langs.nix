{
  den.default.os = { pkgs, ... }: {
    programs.nixvim.plugins = {
      crates.enable = true;
      lsp-signature.enable = true;
      markdown-preview.enable = true;

      lsp = {
        enable = true;
        servers = {
          astro.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          oxfmt.enable = true;
          oxlint.enable = true;
          html.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
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
          ts_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          sqls.enable = true;
          yamlls.enable = true;
          #tailwindcss.enable = true;
        };
      };

      treesitter = {
        enable = true;
        lazyLoad.enable = true;
        lazyLoad.settings.event = "BufRead";
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
          html
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          javascript
          json
          kotlin
          lua
          markdown
          markdown_inline
          nix
          python
          query
          regex
          rust
          ssh_config
          svelte
          tsx
          typescript
          vim
          vimdoc
          vue
          xml
          yaml
        ];
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            css = [ "oxfmt" ];
            html = [ "oxfmt" ];
            javascript = [ "oxfmt" ];
            javascriptreact = [ "oxfmt" ];
            json = [ "oxfmt" ];
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
            typescript = [ "oxfmt" ];
            typescriptreact = [ "oxfmt" ];
            vue = [ "oxfmt" ];
            sh = [ "shfmt" ];
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

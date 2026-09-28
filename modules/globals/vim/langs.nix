{
  den.default.os = { pkgs, self', ... }: {
    programs.nixvim = {

      extraPlugins = [ pkgs.vimPlugins.vim-dotenv ];

      extraPackages = with pkgs; [
        glab
        kotlin
        nixfmt
        pyright
        #self'.packages.dbee
        shfmt
        stylua
        luajitPackages.tree-sitter-cli
        typescript
        typescript-language-server
        vscode-langservers-extracted
      ];

      lsp.servers = {
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
          package = self'.packages.kotlin-lsp;
        };
        marksman.enable = true;
        oxfmt.enable = true;
        oxlint.enable = true;
        nixd = {
          enable = true;
          config = {
            formatting = {
              command = [ "nixfmt" ];
            };
          };
        };
        pylsp.enable = true;
        ts_ls.enable = true;
        rust_analyzer = {
          enable = true;
          #installCargo = false;
          #installRustc = false;
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

      plugins = {
        bullets = {
          enable = true;
          lazyLoad.settings.settings.ft = [
            "markdown"
            "txt"
            "gitcommit"
          ];
        };
        crates = {
          enable = true;
          lazyLoad.settings.ft = "rust";
        };

        lspconfig = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };

        lsp-signature = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };

        markdown-preview = {
          enable = true;
          lazyLoad.settings.ft = "markdown";
        };
        #typescript-tools.enable = true;

        package-info = {
          enable = true;
          lazyLoad.settings.event = [ "BufRead package.json" ];
          settings.hide_up_to_date = true;
        };

        treesitter = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
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
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
          settings = {
            lsp_fallback = true;
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
  };
}

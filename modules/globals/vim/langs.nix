{
  den.default.os = { pkgs, self', ... }: {
    programs.nixvim = {

      extraPackages = with pkgs; [
        biome
        detekt
        glab
        ktlint
        luajitPackages.tree-sitter-cli
        markdownlint-cli
        nixfmt
        oxfmt
        oxlint
        rustfmt
        self'.packages.dbee
        shellcheck
        shfmt
        statix
      ];

      extraPlugins = [ pkgs.vimPlugins.vim-dotenv ];

      lsp.servers = {
        astro.enable = true;
        bashls.enable = true;
        cssls.enable = true;
        dartls.enable = true;
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        emmet_ls.enable = true;
        html.enable = true;
        fsautocomplete.enable = true;
        gradle_ls = {
          enable = true;
          package = pkgs.vscode-extensions.vscjava.vscode-gradle;
        };
        jsonls.enable = true;
        kotlin_lsp = {
          enable = true;
          package = self'.packages.kotlin-lsp;
        };
        marksman.enable = true;
        oxfmt.enable = true;
        oxlint.enable = true;
        nixd.enable = true;
        pylsp.enable = true;
        rust_analyzer = {
          enable = true;
        };
        sqls.enable = true;
        stylelint_lsp.enable = true;
        svelte.enable = true;
        unocss = {
          enable = true;
          package = null;
        };
        vue_ls.enable = true;
        ts_ls.enable = true;
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
          autoInstall.enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
          settings = {
            notify_on_error = true;
            notify_no_formatters = true;
            log_level = "info";
            default_format_opts.lsp_format = "fallback";

            format_on_save.__raw = ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end
                return { timeout_ms = 3000, lsp_fallback = true }
              end
            '';

            formatters_by_ft = {
              astro = [ "biome" ];
              bash = [ "shfmt" ];
              css = [ "oxfmt" ];
              dart = [ "dart_format" ];
              html = [ "oxfmt" ];
              javascript = [ "oxfmt" ];
              json = [ "oxfmt" ];
              kotlin = [ "ktlint" ];
              nix = [ "nixfmt" ];
              rust = [ "rustfmt" ];
              sh = [ "shfmt" ];
              svelte.__raw = ''{ "oxfmt", "lsp", stop_after_first = true }'';
              typescript = [ "oxfmt" ];
              typescriptreact = [ "oxfmt" ];
              vue.__raw = ''{ "oxfmt", "lsp", stop_after_first = true }'';
            };

            formatters.oxfmt.command.__raw = ''
              function(self, ctx)
                local root = require("conform.util").root_file({ "package.json", ".git" })(self, ctx)
                local local_cmd = root and root .. "/node_modules/.bin/oxfmt"
                if local_cmd and vim.fn.executable(local_cmd) == 1 then
                  return local_cmd
                end
                return "oxfmt"
              end
            '';
          };
        };

        lint = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];

          lintersByFt = {
            astro = [ "oxlint" ];
            bash = [ "shellcheck" ];
            css = [ "oxlint" ];
            javascript = [ "oxlint" ];
            json = [ "oxlint" ];
            kotlin = [ "detekt" ];
            markdown = [ "markdownlint" ];
            nix = [ "statix" ];
            sh = [ "shellcheck" ];
            svelte = [ "oxlint" ];
            typescript = [ "oxlint" ];
            typescriptreact = [ "oxlint" ];
            vue = [ "oxlint" ];
          };
        };
      };
    };
  };
}

{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      keymaps = [
        {
          mode = [
            "n"
            "x"
          ];
          key = "<leader>cF";
          action.__raw = ''
            function()
              require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end
          '';
          options.desc = "Format Injected Langs";
        }
      ];

      plugins = {
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            astro
            bash
            css
            diff
            html
            javascript
            json
            kotlin
            lua
            markdown
            markdown_inline
            nix
            python
            regex
            rust
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

        lsp = {
          enable = true;
          servers = {
            lua_ls = {
              enable = true;
              settings.Lua = {
                workspace.checkThirdParty = false;
                codeLens.enable = true;
                completion.callSnippet = "Replace";
                doc.privateName = [ "^_" ];
                hint = {
                  enable = true;
                  setType = false;
                  paramType = true;
                  paramName = "Disable";
                  semicolon = "Disable";
                  arrayIndex = "Disable";
                };
              };
            };
            bashls.enable = true;
            cssls.enable = true;
            #eslint.enable = true;
            html.enable = true;
            jsonls.enable = true;
            marksman.enable = true;
            nixd.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
            sqls.enable = true;
            #tailwindcss.enable = true;
          };
        };

        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;
            enable_check_bracket_line = false;
            fast_wrap = {
              enable = true;
              map = "<M-e>";
              chars = [
                "{"
                "["
                "("
                "\""
                "'"
                "`"
              ];
            };
          };
        };

        markdown-preview.enable = true;

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
  };
}

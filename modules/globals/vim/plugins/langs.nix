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
        auto-save = {
          enable = true;
          settings.enabled = true;
        };
        lsp-signature.enable = true;
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

        fidget = {
          enable = true;
          settings = {
            logger = {
              level = "warn";
              float_precision = 1.0e-2;
            };
            progress = {
              poll_rate = 0;
              suppress_on_insert = true;
              ignore_done_already = false;
              ignore_empty_message = false;
              clear_on_detach = ''
                function(client_id)
                  local client = vim.lsp.get_client_by_id(client_id)
                  return client and client.name or nil
                end
              '';
              notification_group = ''
                function(msg) return msg.lsp_client.name end
              '';
              ignore = [ ];
              lsp = {
                progress_ringbuf_size = 0;
              };
              display = {
                render_limit = 16;
                done_ttl = 3;
                done_icon = "✔";
                done_style = "Constant";
                progress_ttl = 10;
                progress_icon = {
                  pattern = "dots";
                  period = 1;
                };
                progress_style = "WarningMsg";
                group_style = "Title";
                icon_style = "Question";
                priority = 30;
                skip_history = true;
                format_message = ''
                  require ("fidget.progress.display").default_format_message
                '';
                format_annote = ''
                  function (msg) return msg.title end
                '';
                format_group_name = ''
                  function (group) return tostring (group) end
                '';
                overrides = {
                  rust_analyzer = {
                    name = "rust-analyzer";
                  };
                };
              };
            };
            notification = {
              poll_rate = 10;
              filter = "info";
              history_size = 128;
              override_vim_notify = true;
              redirect = {
                __raw = ''
                  function(msg, level, opts)
                    if opts and opts.on_open then
                      return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
                    end
                  end
                '';
              };
              configs = {
                default = {
                  name = "Notifications";
                  icon = "󰏪";
                  group = "Notifications";
                  annote = true;
                  debug = false;
                  debug_rate = 0.25;
                };
              };

              window = {
                normal_hl = "Comment";
                winblend = 0;
                border = "none";
                zindex = 45;
                max_width = 0;
                max_height = 0;
                x_padding = 1;
                y_padding = 0;
                align = "bottom";
                relative = "editor";
              };
              view = {
                stack_upwards = true;
                icon_separator = " ";
                group_separator = "---";
                group_separator_hl = "Comment";
              };
            };
          };
        };

        treesj = {
          enable = true;
          autoLoad = true;
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

        nvim-autopairs = {
          enable = true;
          settings = {
            disable_filetype = [
              "TelescopePrompt"
              "vim"
            ];
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

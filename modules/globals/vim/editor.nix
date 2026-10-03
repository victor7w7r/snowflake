{
  den.default.os =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPlugins = [
          pkgs.vimPlugins.lualine-lsp-progress
          (pkgs.vimUtils.buildVimPlugin {
            name = "neominimap";
            src = pkgs.fetchFromGitHub {
              owner = "Isrothy";
              repo = "neominimap.nvim";
              rev = "0676085d898019f06044923934e38663f5efa290";
              hash = "sha256-EcV/mdleyopQsJ/t/Whl6Yf/2ORb9rnhHuc2Ue1E1Bw=";
            };
          })
        ];

        extraConfigLua = ''
          vim.g.neominimap = {
            auto_enable = false,
            x_multiplier = 1,
            y_multiplier = 1,
            layout = "float",
            float = {
              minimap_width = 20,
              max_minimap_height = 50,
              margin = {
                right = 1,
                top = 0,
                bottom = 1,
              },
              z_index = 1,
              window_border = "none",
            },
            click = {
              enabled = true,
            },
            search = {
              enabled = true,
            },
            mark = {
              enabled = true,
            },
          }
        '';

        plugins = {
          baleia = {
            enable = true;
            lazyLoad.settings.event = [
              "BufNewFile"
              "BufReadPre"
            ];
          };

          better-escape = {
            enable = true;
            lazyLoad.settings.event = [
              "InsertEnter"
              "TermEnter"
            ];
          };

          bufferline = {
            enable = true;
            autoLoad = true;
            settings.options = {
              close_command.__raw = "function(n) Snacks.bufdelete(n) end";
              diagnostics = "nvim_lsp";
              right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
              persist_buffer_sort = true;
              tab_size = 15;
              offsets = [
                {
                  filetype = "neo-tree";
                  text = "NeoTree";
                  text_align = "center";
                  separator = false;
                }
              ];
            };
          };

          ccc = {
            enable = true;
            lazyLoad.settings.cmd = [
              "CccPick"
              "CccConvert"
              "CccHighlighterToggle"
              "CccHighlighterEnable"
              "CccHighlighterDisable"
            ];
          };

          colorizer = {
            enable = true;
            lazyLoad.settings.event = [
              "BufNewFile"
              "BufReadPre"
            ];
          };

          comment-box = {
            enable = true;
            lazyLoad.settings.cmd = [
              "CBd"
              "CBccbox"
              "CBllline"
              "CBline"
            ];
          };

          dropbar = {
            enable = true;
            lazyLoad.settings.event = "BufReadPost";
            settings.bar.update_events.buf = [
              "FileChangedShellPost"
              "TextChanged"
              "ModeChanged"
            ];
          };

          flash = {
            enable = true;
            lazyLoad.settings.event = "DeferredUIEnter";
          };

          inc-rename = {
            enable = true;
            lazyLoad.settings.event = "DeferredUIEnter";
          };

          indent-blankline = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
            ];
            settings = {
              exclude = {
                buftypes = [
                  "terminal"
                  "quickfix"
                ];
                filetypes = [
                  ""
                  "checkhealth"
                  "help"
                  "lspinfo"
                  "packer"
                  "TelescopePrompt"
                  "TelescopeResults"
                  "yaml"
                ];
              };
              indent.char = "│";

              scope = {
                enabled = true;
                show_end = true;
                show_exact_scope = true;
                show_start = true;
              };
            };
          };

          lualine = {
            enable = true;
            autoLoad = true;
            settings = {
              options = {
                theme = "tokyonight";
                globalstatus = true;
                icons_enabled = true;
                component_separators = {
                  left = "";
                  right = "";
                };
                section_separators = {
                  left = "";
                  right = "";
                };
                disabled_filetypes.statusline = [ "snacks_dashboard" ];
              };
              extensions = [
                "aerial"
                "avante"
                "neo-tree"
                "nvim-dap-ui"
                "quickfix"
                "trouble"
              ];
              sections = {
                lualine_a = [
                  {
                    __unkeyed-1 = "mode";
                    icon = "";
                  }
                ];
                lualine_b = [
                  {
                    __unkeyed-1 = "branch";
                    icon = "";
                  }
                ];
                lualine_c = [
                  {
                    __unkeyed-1 = "diff";
                    symbols = {
                      added = " ";
                      modified = " ";
                      removed = " ";
                    };
                  }
                  {
                    __unkeyed = "diagnostics";
                    sources = [ "nvim_diagnostic" ];
                    update_in_insert = true;
                    symbols = {
                      error = " ";
                      warn = " ";
                      info = " ";
                      hint = " ";
                    };
                  }

                  "lsp_progress"
                ];
                lualine_x = [
                  {
                    __unkeyed-1 = "lsp_status";
                    icon = "";
                    ignore_lsp = [ "null-ls" ];
                  }
                  {
                    __unkeyed-1 = "filetype";
                    icon_only = true;
                    separator = "";
                  }
                  "filesize"
                ];
                lualine_y = [
                  {
                    __unkeyed = "fileformat";
                    icon_only = true;
                    separator = "";
                  }
                  {
                    __unkeyed = "encoding";
                    fmt = ''
                      function(str)
                        if str == "utf-8" then return "" end
                        return str
                      end
                    '';
                  }
                ];
                lualine_z = [
                  {
                    __unkeyed = "progress";
                    separator = "";
                  }
                  "location"
                ];
              };
            };
          };

          mini = {
            enable = true;
            lazyLoad.settings.event = "DeferredUIEnter";
            modules = {
              cursorword = { };
              move = { };
              pairs = { };
              pick = { };
              splitjoin = { };
              surround = { };
            };
          };

          multicursor = {
            enable = true;
            lazyLoad.settings.event = "DeferredUIEnter";
          };

          navbuddy = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
            settings.lsp.autoAttach = true;
          };

          nvim-ufo = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
          };

          rainbow-delimiters = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
            settings = {
              strategy."".__raw = ''
                function(bufnr)
                  if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                    return nil
                  end
                  return require("rainbow-delimiters").strategy.global
                end
              '';
              query = {
                "" = "rainbow-delimiters";
                lua = "rainbow-blocks";
              };
              highlight = [
                "RainbowDelimiterRed"
                "RainbowDelimiterYellow"
                "RainbowDelimiterBlue"
                "RainbowDelimiterOrange"
                "RainbowDelimiterGreen"
                "RainbowDelimiterViolet"
                "RainbowDelimiterCyan"
              ];
            };
          };

          snacks.settings = {
            bufdelete.enabled = true;
            bigfile.enabled = true;
            quickfile.enabled = true;
            rename.enabled = true;
            scope.enabled = true;
            words.enabled = true;
          };

          todo-comments = {
            enable = true;
            settings.signs = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
          };

          ts-autotag = {
            enable = true;
            lazyLoad.settings.ft = [
              "html"
              "xml"
              "vue"
              "svelte"
              "astro"
            ];
            settings.opts = {
              enable_close = true;
              enable_rename = true;
              enable_close_on_slash = false;
            };
          };

          undotree = {
            enable = true;
            lazyLoad.settings.cmd = "UndotreeToggle";
            settings = {
              autoOpenDiff = true;
              focusOnToggle = true;
              windowLayout = 3;
              treeNodeShape = "";
              windowWidth = 50;
            };
          };

          yanky = {
            enable = true;
            lazyLoad.settings.event = [
              "BufReadPost"
              "BufNewFile"
              "BufWritePre"
            ];
            settings = {
              highlight.timer = 150;
              preserveCursorPosition.enabled = true;
              ring = {
                storage = "sqlite";
                history_length = 30;
              };
              system_clipboard.sync_with_ring = true;
            };
          };
        };
      };
    };
}

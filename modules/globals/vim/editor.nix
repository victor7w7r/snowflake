{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      extraPlugins = [
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

      plugins = {
        autoclose = {
          enable = true;
          lazyLoad.settings.event = "InsertEnter";
        };

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
            middle_mouse_command = "bdelete! %d";
            right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
            tab_size = 15;
            separator_style = "thin";
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
          settings = { };
        };

        image = {
          enable = true;
          lazyLoad.settings = {
            event = [ "BufEnter" ];
            ft = [
              "markdown"
              "org"
              "norg"
            ];
          };
          settings = {
            integrations.neorg.enabled = true;
            editor_only_render_when_focused = true;
            tmux_show_only_in_active_window = true;
          };
        };

        inc-rename = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
        };

        indent-blankline = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufWritePost"
            "BufNewFile"
          ];
          settings = {
            indent = {
              smart_indent_cap = true;
              char = " ";
            };
            scope = {
              enabled = true;
              char = "│";
            };
          };
        };

        lualine = {
          enable = true;
          autoLoad = true;
          settings.options = {
            theme = "palenight";
            globalstatus = true;
            disabled_filetypes = [
              "dashboard"
              "lazy"
              "alpha"
            ];
            sections = {
              lualine_a = [
                {
                  __unkeyed = "mode";
                  icon = "";
                }
              ];
              lualine_b = [
                {
                  __unkeyed = "branch";
                  icon = "";
                }
                "diff"
                {
                  __unkeyed = "project";
                  format = "name";
                  no_project = "N/A";
                  separator = " ";
                }
              ];
              lualine_c = [
                {
                  __unkeyed = "filename";
                  path = 1;
                  symbols = {
                    modified = "";
                    readonly = "";
                  };
                }
                "lsp_progress"
              ];
              lualine_x = [
                "diagnostics"
                "encoding"
                {
                  __unkeyed = "filetype";
                  icon_only = true;
                }
              ];
              lualine_y = [ "progress" ];
              lualine_z = [ "location" ];
            };
          };
        };

        mini = {
          enable = true;
          lazyLoad.settings.cmd = "DeferredUIEnter";
          modules = {
            comment = {};
            cursorword = {};
            move = {};
            pairs = {};
            splitjoin = {};
            surround = {};
          };
        };

        navbuddy = {
          enable = true;
          lazyLoad.settings.cmd = "LspAttach";
          settings.lsp.autoAttach = true;
        };

        nvim-ufo = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };

        rainbow-delimiters = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
          settings = {
            strategy = {
              "".__raw = ''
                function(bufnr)
                  if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                    return nil
                  end
                  return require("rainbow-delimiters").strategy.global
                end
              '';
            };
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
          lazyLoad.settings.event = "BufReadPost";
        };

        ts-autotag = {
          enable = true;
          lazyLoad.settings.event = "InsertEnter";
          settings.opts = {
            enable_close = true;
            enable_rename = true;
            enable_close_on_slash = false;
            per_filetype.html.enable_close = false;
          };
        };

        undotree = {
          enable = true;
          lazyLoad.settings.cmd = "UndotreeShow";
          settings = {
            autoOpenDiff = true;
            focusOnToggle = true;
          };
        };

        visual-multi = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };

        visual-whitespace = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
          settings = {
            enabled = true;
            lead = true;
            nbsp = true;
            space = true;
            tab = true;
            trail = true;
          };
        };

        yanky = {
          enable = true;
          lazyLoad.settings.event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };
      };

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
          git = {
            enabled = false,
          },
          search = {
            enabled = false,
          },
        }
      '';
    };
  };
}

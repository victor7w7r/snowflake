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
        baleia.enable = true;
        better-escape.enable = true;
        colorizer.enable = true;
        ccc.enable = true;
        endec.enable = true;

        flash = {
          enable = true;
          settings = { };
        };

        image = {
          enable = true;
          settings = {
            integrations.neorg.enabled = true;
            editor_only_render_when_focused = true;
            tmux_show_only_in_active_window = true;
          };
        };

        inc-rename.enable = true;
        indent-blankline = {
          enable = true;
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

        illuminate.enable = true;

        persistence = {
          enable = true;
          lazyLoad.settings.event = "BufReadPre";
        };

        rainbow-delimiters = {
          enable = true;
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

        todo-comments = {
          enable = true;
          settings = {
            signs = true;
          };
        };

        undotree = {
          enable = true;
          settings = {
            autoOpenDiff = true;
            focusOnToggle = true;
          };
        };

        visual-whitespace = {
          enable = true;
          settings = {
            enabled = true;
            lead = true;
            nbsp = true;
            space = true;
            tab = true;
            trail = true;
          };
        };

        yanky.enable = true;
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
          diagnostic = {
            enabled = false,
          },
          git = {
            enabled = true,
            mode = "sign",
            priority = 6,
          },
          search = {
            enabled = false,
          },
          treesitter = {
            enabled = true,
          },
        }
      '';
    };
  };
}

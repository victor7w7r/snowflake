{
  den.default.os.programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true;
        terminal_colors = true;
        dim_inactive = false;
        lualine_bold = true;
        on_colors = "function(colors) colors.comment = '#b4bcd0' end";
        styles = {
          comments.italic = true;
          keywords.italic = true;
          functions.bold = true;
          sidebars = "transparent";
          floats = "transparent";
        };
      };
    };

    plugins = {
      bufferline = {
        enable = true;
        settings.options.__raw = ''
          {
            indicator = {
              style = "none",
            },
            style = "none",
            mode = "buffers",
            numbers = "none",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = "bdelete! %d",
            buffer_close_icon = "x",
            modified_icon = "",
            close_icon = "X",
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 15,
            truncate_names = false,
            tab_size = 15,
            diagnostics = false,
            show_buffer_icons = false,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = false,
            show_duplicate_prefix = true,
            persist_buffer_sort = true,
            separator_style = "none",
            always_show_bufferline = true,
            -- enforce_regular_tabs = true,
          }
        '';
      };

      lualine = {
        enable = true;
        settings.options = {
          theme = "nightfly";
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

        modicator.enable = true;
        notify.enable = true;
        scrollview.enable = true;

        smear-cursor = {
          enable = true;
        };

        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
            ui-select.enable = true;
            zoxide.enable = true;
            file-browser.enable = true;
          };
        };

        tiny-glimmer.enable = true;

        tmux-navigator = {
          enable = true;
          settings.no_mappings = 1;
        };

        toggleterm.enable = true;

        yazi = {
          enable = true;
          autoLoad = true;
          settings = {
            log_level = "debug";
            open_for_directories = true;
            enable_mouse_support = true;
            floating_window_scaling_factor = 1;
            yazi_floating_window_border = "rounded";
            yazi_floating_window_winblend = 20;
          };
        };

        snacks = {
          enable = true;
          settings = {
            bigfile.enable = true;
            bufdelete.enable = true;
            explorer = {
              enabled = true;
              replace_netrw = true;
            };
            git.enable = true;
            gitbrowse.enable = true;
            image.enable = true;
            indent.enabled = true;
            input.enabled = true;
            picker = {
              enabled = true;
              layout.preset = "telescope";
            };
            quickfile.enabled = true;
            scope.enable = true;
            scroll.enabled = false;
            terminal.enable = true;
          };
        };

        web-devicons.enable = true;
        wilder.enable = true;

        zen-mode = {
          enable = true;
          autoLoad = true;
          settings = {
            window = {
              backdrop = 0.95;
              width = 0.8;
              height = 1;
              options.signcolumn = "no";
            };
            plugins = {
              options = {
                enabled = true;
                ruler = false;
                showcmd = false;
              };
              twilight.enabled = false;
              gitsigns.enabled = true;
              tmux.enabled = false;
            };
          };
        };
      };
    };
  };
}

{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      colorschemes.tokyonight = {
        enable = true;
        lazyLoad.enable = true;
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

      extraPlugins = [ pkgs.vimPlugins.lualine-lsp-progress ];

      plugins = {
        hardtime = {
          enable = true;
          settings = {
            disabled_keys = { };
            disable_mouse = false;
            timeout = 2000;
            restriction_mode = "hint";
          };
        };

        modicator.enable = true;
        notify.enable = true;

        scrollview


        .enable = true;

        smear-cursor = {
          enable = true;
        };

        snacks = {
          enable = true;
          settings = {
            bigfile.enable = true;
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

        telescope = {
          enable = true;
          settings.extensions.media_files = {
            filetypes = [
              "png"
              "webp"
              "jpg"
              "jpeg"
            ];
            find_cmd = "find";
          };

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

        toggleterm = {
          enable = true;
          lazyLoad.settings.cmd = "ToggleTerm";
        };

        web-devicons = {
          enable = true;
          settings = {
            color_icons = true;
            default = true;
          };
        };

        wilder.enable = true;

        yazi = {
          enable = true;
          lazyLoad.settings.cmd = [ "Yazi" ];
          settings = {
            log_level = "debug";
            open_for_directories = true;
            enable_mouse_support = true;
            floating_window_scaling_factor = 1;
            yazi_floating_window_border = "rounded";
            yazi_floating_window_winblend = 20;
          };
        };

        zen-mode = {
          enable = true;
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

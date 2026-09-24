{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
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

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "spinner";
          src = pkgs.fetchFromGitHub {
            owner = "xieyonn";
            repo = "spinner.nvim";
            rev = "v1.3.0";
            hash = "sha256-w5uhTVYRgkVCbJ5wrNAAs8bwSpH+4REAr9gaZrbknH8=";
          };
        })
      ];

      plugins = {
        bufferline = {
          enable = true;
          settings = {
            options = {
              always_show_bufferline = true;
              buffer_close_icon = "×";
              close_command = "bdelete! %d";
              close_icon = "×";
              color_icons = true;
              diagnostics = false;

              indicator.style = "none";
              left_mouse_command = "buffer %d";
              max_name_length = 18;
              max_prefix_length = 15;
              middle_mouse_command = "bdelete! %d";
              mode = "buffers";
              modified_icon = "";
              numbers = "none";
              persist_buffer_sort = true;
              right_mouse_command = "bdelete! %d";
              show_buffer_close_icons = true;
              show_buffer_icons = true;
              show_close_icon = true;
              show_duplicate_prefix = true;
              show_tab_indicators = false;
              tab_size = 15;
              truncate_names = false;
            };
            highlights.buffer_selected = {
              bold = true;
              italic = true;
            };
          };
        };

        lualine = {
          enable = true;
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
        };

        modicator.enable = true;
        notify.enable = true;
        scrollview.enable = true;

        smear-cursor = {
          enable = true;
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
            override_by_extension = {
              nix = {
                icon = "󱄅";
                color = "#7EBAE4";
                name = "Nix";
              };
              json = {
                icon = "󰘦";
                color = "#F1E05A";
                name = "Json";
              };
              md = {
                icon = "󰍔";
                color = "#519ABA";
                name = "Markdown";
              };
              js = {
                icon = "󰌞";
                color = "#F1E05A";
                name = "JavaScript";
              };
              ts = {
                icon = "󰛦";
                color = "#3178C6";
                name = "TypeScript";
              };
              py = {
                icon = "󰌠";
                color = "#FFBC03";
                name = "Python";
              };
              txt = {
                icon = "󰈙";
                color = "#6D8086";
                name = "Text";
              };
            };
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

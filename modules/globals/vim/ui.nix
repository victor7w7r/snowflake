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
        pkgs.vimPlugins.lualine-lsp-progress
        (pkgs.vimUtils.buildVimPlugin {
          name = "spinner";
          src = pkgs.fetchFromGitHub {
            owner = "xieyonn";
            repo = "spinner.nvim";
            rev = "v1.3.0";
            hash = "sha256-1cwH8YXcu2yhqzjaV0TItY1YOXtLG3d+PynZGH8HWNA=";
          };
        })
      ];

      plugins = {
        bufferline = {
          enable = true;
          settings.options = {
            close_command.__raw = "function(n) require('mini.bufremove').delete(n, false) end";
            diagnostics = "nvim_lsp";
            middle_mouse_command = "bdelete! %d";
            right_mouse_command.__raw = "function(n) require('mini.bufremove').delete(n, false) end";
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

        hardtime = {
          enable = true;
          settings = {
            disabled_keys = { };
            disable_mouse = false;
            timeout = 2000;
            restriction_mode = "hint";
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
          modules.bufremove = { };
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

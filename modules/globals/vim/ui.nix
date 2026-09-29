{
  den.default.os = { lib, pkgs, ... }: {
    programs.nixvim = {

      extraPlugins = [ pkgs.vimPlugins.lualine-lsp-progress ];

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

      plugins = {
        hardtime = {
          enable = true;
          lazyLoad.settings.event = "BufEnter";
          settings = {
            disabled_keys = {
              "<Down>" = lib.generators.mkLuaInline "{}";
              "<Left>" = lib.generators.mkLuaInline "{}";
              "<Right>" = lib.generators.mkLuaInline "{}";
              "<Up>" = lib.generators.mkLuaInline "{}";
            };
            disable_mouse = false;
            timeout = 2000;
            restriction_mode = "hint";
          };
        };

        notify = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
        };

        scrollview = {
          enable = true;
          lazyLoad.settings.event = [
            "BufNewFile"
            "BufReadPost"
          ];
        };

        smear-cursor = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
          settings = {
            cursor_color = "#a77ede";
            cursor_color_insert_mode = "#79bbed";
            normal_bg = "#282828";
            trailing_stiffness = 0.3;
            stiffness = 0.5;
            damping = 0.67;
            distance_stop_animating = 0.5;
          };
        };

        snacks = {
          enable = true;
          autoLoad = true;
          settings = {
            animate.enable = false;
            debug.enabled = false;
            dim.enabled = false;
            explorer.enabled = false;
            gh.enabled = false;
            image.enabled = true;
            indent.enabled = false;
            input.enabled = true;
            keymap.enabled = false;
            layout.enabled = false;
            notify.enabled = false;
            notifier.enabled = false;
            picker = {
              enabled = true;
              layout.preset = "telescope";
            };
            scratch.enabled = true;
            scroll.enabled = false;
            statuscolumn.enabled = true;
            terminal.enabled = true;
            toggle.enabled = true;
            zen.enabled = true;
          };
        };

        tiny-glimmer = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
          settings = {
            enabled = true;
            animations = {
              pulse = {
                chars_for_max_duration = 10;
                max_duration = 400;
                min_duration = 200;
              };
              rainbow = {
                chars_for_max_duration = 10;
              };
            };
            overwrite = {
              paste = {
                enabled = true;
              };
              yank = {
                default_animation = "rainbow";
              };
            };
            refresh_interval_ms = 5;
          };
        };

        web-devicons = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
          settings.override = {
            js = {
              icon = "󰌞";
              color = "#F7DF1E";
              name = "Js";
            };
            jsx = {
              icon = "󰌞";
              color = "#61DAFB";
              name = "Jsx";
            };
            mjs = {
              icon = "󰌞";
              color = "#F7DF1E";
              name = "Mjs";
            };
            cjs = {
              icon = "󰌞";
              color = "#F7DF1E";
              name = "Cjs";
            };

            ts = {
              icon = "󰛦";
              color = "#3178C6";
              name = "Ts";
            };
            tsx = {
              icon = "󰛦";
              color = "#61DAFB";
              name = "Tsx";
            };
            "d.ts" = {
              icon = "󰛦";
              color = "#2B5B84";
              name = "Dts";
            };
          };
        };

        yazi = {
          enable = true;
          lazyLoad.settings.cmd = "Yazi";
          settings = {
            log_level = "debug";
            open_for_directories = true;
            enable_mouse_support = true;
            floating_window_scaling_factor = 1;
            yazi_floating_window_border = "rounded";
            yazi_floating_window_winblend = 20;
          };
        };
      };
    };
  };
}

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

        modicator = {
          enable = true;
          lazyLoad.settings.event = [
            "BufNewFile"
            "BufReadPre"
          ];
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
        };

        tmux-navigator = {
          enable = true;
          autoLoad = true;
          settings.no_mappings = 1;
        };

        web-devicons = {
          enable = true;
          lazyLoad.settings.event = "DeferredUIEnter";
          settings = {
            color_icons = true;
            default = true;
          };
        };

        wilder = {
          enable = true;
          lazyLoad.settings.cmd = "CmdlineEnter";
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

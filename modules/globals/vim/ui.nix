{
  den.default.os.programs.nixvim = {
    plugins = {
      auto-save = {
        enable = true;
        settings.enabled = true;
      };
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

      image = {
        enable = true;
        settings = {
          integrations.neorg.enabled = true;
          editor_only_render_when_focused = true;
          tmux_show_only_in_active_window = true;
        };
      };

      navic = {
        enable = true;
        settings = {
          separator = "  ";
          highlight = true;
          depthLimit = 5;
          lsp = {
            autoAttach = true;
          };
          icons = {
            Array = "󱃵  ";
            Boolean = "  ";
            Class = "  ";
            Constant = "  ";
            Constructor = "  ";
            Enum = " ";
            EnumMember = " ";
            Event = " ";
            Field = "󰽏 ";
            File = " ";
            Function = "󰡱 ";
            Interface = " ";
            Key = "  ";
            Method = " ";
            Module = "󰕳 ";
            Namespace = " ";
            Null = "󰟢 ";
            Number = " ";
            Object = "  ";
            Operator = " ";
            Package = "󰏖 ";
            String = " ";
            Struct = " ";
            TypeParameter = " ";
            Variable = " ";
          };
        };
      };

      illuminate.enable = true;

      notify.enable = true;
      #noice.enable = true;
      toggler.enable = true;
      tiny-glimmer.enable = true;
      scrollview.enable = true;
      smear-cursor = {
        enable = true;
        settings = {

        };
      };
      persistence = {
        enable = true;
        lazyLoad.settings.event = "BufReadPre";
      };
      colorizer.enable = true;
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

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
          zoxide.enable = true;
          file-browser.enable = true;
        };
      };

      tmux-navigator = {
        enable = true;
        settings.no_mappings = 1;
      };

      toggleterm = {
        enable = true;
      };

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
      fastaction.enable = true;
      web-devicons.enable = true;
      modicator.enable = true;
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
}

{
  den.default.os = {
    programs.nixvim = {
      plugins = {

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
        neo-tree = {
          enable = true;
          settings = {
            close_if_last_window = true;
            filesystem = {
              follow_current_file.enabled = true;
              filtered_items.visible = true;
            };
          };
        };
        notify.enable = true;
        noice.enable = true;
        smear-cursor.enable = true;
        persistence.enable = true;
        colorizer.enable = true;
        bufferline = {
          enable = true;
          settings.options = {
            close_command.__raw = "function(n) Snacks.bufdelete(n) end";
            right_mouse_command.__raw = "function(n) Snacks.bufdelete(n) end";
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            diagnostics_indicator.__raw = ''
              function(_, _, diag)
                local icons = { Error = " ", Warn = " ", Info = " ", Hint = " " }
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                  .. (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
              end
            '';
            offsets = [
              {
                filetype = "snacks_layout_box";
              }
            ];
            get_element_icon.__raw = ''
              function(opts)
                local ft_icons = {
                  octo = " ",
                  gh = " ",
                  ["markdown.gh"] = " ",
                }
                return ft_icons[opts.filetype]
              end
            '';
            style_preset.__raw = "require('bufferline').style_preset.default";
            themable = true;
            show_buffer_close_icons = true;
            show_close_icon = false;
            separator_style = "thin";
            indicator = {
              style = "icon";
              icon = "▎";
            };
            modified_icon = "● ";
            left_trunc_marker = "";
            right_trunc_marker = "";
          };
          settings.highlights.__raw = ''
            (function()
              local ok, bufferline = pcall(require, "catppuccin.special.bufferline")
              if ok then
                return bufferline.get_theme()
              end
              return {}
            end)()
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

        web-devicons.enable = true;
      };
    };
  };
}

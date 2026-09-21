{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      plugins = {

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

        web-devicons.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [
        persistence-nvim
      ];

      extraConfigLua = ''
        require("persistence").setup({})
        vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
        vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select Session" })
        vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
        vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })
      '';
    };
  };
}

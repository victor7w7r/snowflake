{
  den.default.os.programs.nixvim.plugins = {
    blame.enable = true;
    conflict.enable = true;

    lazygit = {
      enable = true;
      lazyLoad.settings.cmd = "LazyGit";
      settings = {
        floating_window_winblend = 0;
        floating_window_scaling_factor = 0.9;
        floating_window_border_chars = [
          "╭"
          "─"
          "╮"
          "│"
          "╯"
          "─"
          "╰"
          "│"
        ];
        floating_window_use_plenary = 0;
        use_neovim_remote = 1;
        use_custom_config_file_path = 0;
        config_file_path = [ ];
      };
    };

    diffview = {
      enable = true;
      settings.view.merge_tool.layout = "diff3_mixed";
      lazyLoad.settings = {
        cmd = [
          "DiffviewOpen"
          "DiffviewClose"
          "DiffviewFileHistory"
          "DiffviewToggleFiles"
          "DiffviewFocusFiles"
        ];
        keys = [
          {
            __unkeyed-1 = "<leader>gd";
            __unkeyed-2.__raw = ''
              function()
                local lib = require("diffview.lib")
                if lib.get_current_view() then
                  vim.cmd("DiffviewClose")
                else
                  vim.cmd("DiffviewOpen")
                end
              end
            '';
            desc = "Toggle Diffview";
          }
          {
            __unkeyed-1 = "<leader>gH";
            __unkeyed-2 = "<cmd>DiffviewFileHistory %<cr>";
            desc = "File History";
          }
        ];
      };
    };

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
          untracked.text = "▎";
        };
        signs_staged = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
        on_attach = {
          __raw = ''
            function(buffer)
              local gs = package.loaded.gitsigns

              local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
              end

              map("n", "]h", function()
                if vim.wo.diff then
                  vim.cmd.normal({ "]c", bang = true })
                else
                  gs.nav_hunk("next")
                end
              end, "Next Hunk")
              map("n", "[h", function()
                if vim.wo.diff then
                  vim.cmd.normal({ "[c", bang = true })
                else
                  gs.nav_hunk("prev")
                end
              end, "Prev Hunk")
              map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
              map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
              map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
              map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
              map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
              map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
              map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
              map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
              map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
              map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
              map("n", "<leader>ghd", gs.diffthis, "Diff This")
              map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
              map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end
          '';
        };
      };
    };
  };
}

{
  den.default.os.programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }
    ];

    diagnostic.settings = {
      virtual_text = true;
      severity_sort = true;
      float.border = "rounded";
    };

    plugins = {
      dbee.enable = true;
      actions-preview.enable = true;
      arrow.enable = true;
      #lsp-progress.enable = true;
      sqlite-lua.enable = true;
      comment.enable = true;
      dial.enable = true;
      autoclose.enable = true;
      yanky.enable = true;
      comment-box.enable = true;
      compiler.enable = true;
      nvim-lightbulb.enable = true;
      inc-rename.enable = true;
      navbuddy.enable = true;
      glance = {
        enable = true;
        settings = {
          border.enable = true;
        };
      };

      undotree = {
        enable = true;
        settings = {
          autoOpenDiff = true;
          focusOnToggle = true;
        };
      };

      dropbar = {
        enable = true;
        settings.bar.update_events.buf = [
          # 'BufModifiedSet' is not available in this Neovim build
          "FileChangedShellPost"
          "TextChanged"
          "ModeChanged"
        ];
      };

      rest.enable = true;

      flash = {
        enable = true;
        settings = { };
      };

      nvim-ufo = {
        enable = true;
        lazyLoad.settings.event = "BufEnter";
      };

      package-info = {
        enable = true;
        lazyLoad.settings = {
          event = [ "BufRead package.json" ];
        };

        settings = {
          hide_up_to_date = true;
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          enableDiagnostics = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          close_if_last_window = true;
          filesystem = {
            follow_current_file.enabled = true;
            filtered_items.visible = true;
          };
        };
      };

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

      colorful-menu = {
        enable = true;
        settings = {
          ls = {
            lua_ls.arguments_hl = "@comment";
            ts_ls.extra_info_hl = "@comment";
          };
          fallback_highlight = "@variable";
          max_width = 60;
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

      grug-far = {
        enable = true;
        settings.headerMaxWidth = 80;
        lazyLoad.settings = {
          cmd = "GrugFar";
          keys = [
            {
              __unkeyed-1 = "<leader>sr";
              mode = [
                "n"
                "x"
              ];
              __unkeyed-2.__raw = ''
                function()
                  local grug = require("grug-far")
                  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                  grug.open({
                    transient = true,
                    prefills = {
                      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                  })
                end
              '';
              desc = "Search and Replace";
            }
          ];
        };
      };

      project-nvim.enable = true;

      rainbow-delimiters = {
        enable = true;
        settings = {
          strategy = {
            "".__raw = ''
              function(bufnr)
                if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                  return nil
                end
                return require("rainbow-delimiters").strategy.global
              end
            '';
          };
          query = {
            "" = "rainbow-delimiters";
            lua = "rainbow-blocks";
          };
          highlight = [
            "RainbowDelimiterRed"
            "RainbowDelimiterYellow"
            "RainbowDelimiterBlue"
            "RainbowDelimiterOrange"
            "RainbowDelimiterGreen"
            "RainbowDelimiterViolet"
            "RainbowDelimiterCyan"
          ];
        };
      };

      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };

      trouble = {
        enable = true;
        settings.modes.lsp.win.position = "right";
      };

      ts-autotag = {
        enable = true;
        settings = {
          opts = {
            enable_close = true;
            enable_rename = true;
            enable_close_on_slash = false;
          };
          per_filetype.html.enable_close = false;
        };
      };
    };
  };
}

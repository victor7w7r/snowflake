{
  den.default.os.programs.nixvim = {
    keymaps = [
      {
        action = ":t '><CR>";
        key = "<S-A-Down>";
        mode = "x";
        options.desc = "Duplicate selected lines down";
      }
      {
        action = ":t '><CR>";
        key = "<A-S-j>";
        mode = "x";
        options.desc = "Duplicate selected lines down";
      }
      {
        action = "<cmd>t .<CR>";
        key = "<S-A-Down>";
        mode = "n";
        options.desc = "Duplicate line down";
      }
      {
        action = "<cmd>t .<CR>";
        key = "<A-S-j>";
        mode = "n";
        options.desc = "Duplicate line down";
      }
      {
        action = "<cmd>quitall<CR><esc>";
        key = "<leader>qq";
        mode = "n";
        options = {
          desc = "Quit all";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>qd";
        action.__raw = ''
          function()
            vim.cmd("Neotree close")
            vim.cmd("Neominimap Toggle")
            vim.cmd("silent! %bd!")
            Snacks.dashboard()
          end
        '';
        options = {
          desc = "Close all buffers and go to dashboard";
          silent = true;
        };
      }
      {
        action = "<cmd>lua Snacks.scratch()<CR>";
        key = "<leader>.";
        mode = "n";
        options.desc = "Toggle scratch";
      }
      {
        action = "<cmd>lua Snacks.scratch.select()<CR>";
        key = "<leader>,";
        mode = "n";
        options.desc = "Select scratch";
      }
      {
        action = "<CMD>vnew<CR>";
        key = "<leader>bn";
        mode = "n";
        options.desc = "Vertical Split";
      }
      {
        action = "<cmd>AerialToggle!<CR>";
        key = "<leader>a";
        mode = "n";
        options.desc = "Aerial Toggle";
      }
      {
        action = "<cmd>AerialPrev<CR>";
        key = "{";
        mode = "n";
        options.desc = "Aerial Prev";
      }
      {
        action = "<cmd>AerialNext<CR>";
        key = "}";
        mode = "n";
        options.desc = "Aerial Next";
      }
      {
        action.__raw = ''
          function()
            return require('grug-far').open({
              prefills = { search = vim.api.nvim_get_current_line() };
            })
          end
        '';
        mode = [
          "n"
          "v"
        ];
        key = "<Leader>sr";
        options.desc = "GrugFar current line";
      }
      {
        action = "<cmd>GrugFar<CR>";
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ss";
        options.desc = "GrugFar";
      }
      {
        action = "<cmd>GrugFar<CR>";
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ss";
        options.desc = "GrugFar";
      }
      {
        action = ''<cmd>lua require("flash").jump()<CR>'';
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>sj";
        options.desc = "Flash Jump";
      }
      {
        action = ''<cmd>lua require("flash").treesitter()<CR>'';
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>sJ";
        options.desc = "Flash Treesitter";
      }
      {
        action = ''<cmd>lua require("flash").remote()<CR>'';
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>sr";
        options.desc = "Flash Remote";
      }
      {
        action = ''<cmd>lua require("flash").treesitter_search()<CR>'';
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>sR";
        options.desc = "Flash Treesitter Search";
      }
      {
        action = ''<cmd>lua require("flash").toggle()<CR>'';
        mode = [ "n" ];
        key = "<leader>ts";
        options.desc = "Flash Toggle";
      }
      {
        action = ''<cmd>lua require("actions-preview").code_actions()<CR>'';
        key = "<leader>ca";
        mode = "n";
        options.desc = "Actions Preview";
      }
      {
        action = ''<cmd>lua require("nvim-toggler").toggle<CR>'';
        key = "<leader>cl";
        mode = "n";
        options.desc = "Toggle";
      }
      {
        action = "<cmd>CompilerOpen<CR>";
        key = "<leader>co";
        mode = "n";
        options.desc = "Compiler Open";
      }
      {
        action = "<cmd>CompilerRedo<CR>";
        key = "<leader>cr";
        mode = "n";
        options.desc = "Compiler Redo";
      }
      {
        action = "<cmd>Trouble symbols toggle focus=false<CR>";
        key = "<leader>cn";
        mode = "n";
        options.desc = "Trouble symbols";
      }
      {
        action = "<cmd>CompilerStop<CR>";
        key = "<leader>cs";
        mode = "n";
        options.desc = "Compiler Stop";
      }
      {
        action = "<cmd>CompilerToggleResults<CR>";
        key = "<leader>ctr";
        mode = "n";
        options.desc = "Compiler Toggle Results";
      }
      {
        action = "<cmd>Trouble diagnostics toggle<cr>";
        key = "<leader>xx";
        mode = "n";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        key = "<leader>xX";
        mode = "n";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        action = "<cmd>lua Snacks.terminal()<CR>";
        key = "<leader>tt";
        mode = "n";
        options.desc = "Toggle Terminal";
      }
      {
        action = "<cmd>lua Snacks.lazygit()<CR>";
        key = "<leader>gg";
        mode = "n";
        options.desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Diff view";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>DiffviewClose<CR>";
        options.desc = "Close diff view";
      }
      {
        mode = "n";
        key = "<leader>oc";
        action = "<cmd>lua require('goto-preview').close_all_win()<CR>";
        options.desc = "Preview Close Wins";
      }
      {
        mode = "n";
        key = "<leader>od";
        action = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>";
        options.desc = "Preview Definition";
      }
      {
        mode = "n";
        key = "<leader>ot";
        action = "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>";
        options.desc = "Preview Type Definition";
      }
      {
        mode = "n";
        key = "<leader>oi";
        action = "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>";
        options.desc = "Preview Implementation";
      }
      {
        mode = "n";
        key = "<leader>oD";
        action = "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>";
        options.desc = "Preview Declaration";
      }
      {
        mode = "n";
        key = "<leader>or";
        action = "<cmd>lua require('goto-preview').goto_preview_references()<CR>";
        options.desc = "Preview Declaration";
      }
      {
        action.__raw = ''
          function()
            if _G.Snacks ~= nil and _G.Snacks.picker ~= nil then
              Snacks.picker.yanky()
            elseif pcall(require, "telescope") then
              require("telescope").extensions.yank_history.yank_history({})
            else
              vim.cmd([[YankyRingHistory]])
            end
          end
        '';
        key = "<leader>p";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Open Yank History";
      }
      {
        action = "<Plug>(YankyYank)";
        key = "y";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yank";
      }
      {
        action = "<Plug>(YankyPutAfter)";
        key = "p";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky Put after";
      }
      {
        action = "<Plug>(YankyPutBefore)";
        key = "P";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Put before";
      }
      {
        action = "<Plug>(YankyGPutAfter)";
        key = "gp";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky Put after selection";
      }
      {
        action = "<Plug>(YankyGPutBefore)";
        key = "gP";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Yanky Put before selection";
      }
      {
        action = "<Plug>(YankyPreviousEntry)";
        key = "<C-p>";
        mode = "n";
        options.desc = "Cycle yank history back";
      }
      {
        action = "<Plug>(YankyNextEntry)";
        key = "<C-n>";
        mode = "n";
        options.desc = "Cycle yank history forward";
      }
      {
        action = "<Plug>(YankyPutIndentAfterLinewise)";
        key = "]p";
        mode = "n";
        options.desc = "Put indented after (linewise)";
      }
      {
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
        key = "[p";
        mode = "n";
        options.desc = "Put indented before (linewise)";
      }
      {
        action = "<Plug>(YankyPutIndentAfterShiftRight)";
        key = ">p";
        mode = "n";
        options.desc = "Put and indent right";
      }
      {
        action = "<Plug>(YankyPutIndentAfterShiftLeft)";
        key = "<p";
        mode = "n";
        options.desc = "Put and indent left";
      }
      {
        action = "<Plug>(YankyPutIndentBeforeShiftRight)";
        key = ">P";
        mode = "n";
        options.desc = "Put before and indent right";
      }
      {
        action = "<Plug>(YankyPutIndentBeforeShiftLeft)";
        key = "<P";
        mode = "n";
        options.desc = "Put before and indent left";
      }
      {
        action = "<Plug>(YankyPutAfterFilter)";
        key = "=p";
        mode = "n";
        options.desc = "Put after filter";
      }
      {
        action = "<Plug>(YankyPutBeforeFilter)";
        key = "=P";
        mode = "n";
        options.desc = "Put before filter";
      }
      {
        action = "<cmd>Navbuddy<CR>";
        key = "<leader><F6>";
        mode = "n";
        options = {
          silent = true;
          desc = "Open up navbuddy";
        };
      }
      {
        action = "<cmd>UndotreeToggle<CR>";
        key = "<leader><F7>";
        mode = "n";
        options.desc = "UndoTree";
      }
      {
        action = "<cmd>IncRename<CR>";
        key = "<leader>rn";
        mode = "n";
        options.desc = "IncRename";
      }
      {
        action = "<cmd>Neominimap Toggle<CR>";
        key = "<leader>tm";
        mode = "n";
        options.desc = "Neominimap Toggle";
      }
      {
        action = "<cmd>Neominimap Refresh<CR>";
        key = "<leader>nr";
        mode = "n";
        options.desc = "Neominimap Refresh";
      }
      {
        action = "<cmd>Neominimap Focus<CR>";
        key = "<leader>nf";
        mode = "n";
        options.desc = "Neominimap Focus";
      }

      {
        action = "<cmd>lua require('multicursor-nvim').matchAddCursor(1)<CR>";
        key = "<leader>mn";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Match Next";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').matchAddCursor(-1)<CR>";
        key = "<leader>mp";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Match Prev";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').matchSkipCursor(1)<CR>";
        key = "<leader>ms";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Match Skip";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').matchAllAddCursors()<CR>";
        key = "<leader>ma";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Match All";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').lineAddCursor(-1)<CR>";
        key = "<leader>m<up>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Add Line Above";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').lineAddCursor(1)<CR>";
        key = "<leader>m<down>";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Add Line Below";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').handleMouse<CR>";
        key = "<C-LeftMouse>";
        mode = "n";
        options.desc = "Multi: Mouse Add Cursor";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').handleMouseDrag<CR>";
        key = "<C-LeftDrag>";
        mode = "n";
        options.desc = "Multi: Mouse Drag";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').handleMouseRelease<CR>";
        key = "<C-LeftRelease>";
        mode = "n";
        options.desc = "Multi: Mouse Release";
      }
      {
        action = "<cmd>lua require('multicursor-nvim').toggleCursor<CR>";
        key = "<leader>mt";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Multi: Toggle Cursor";
      }
      {
        action = ''<cmd>lua require("ufo").openAllFolds()'';
        key = "zR";
        mode = "n";
        options.desc = "Open all folds";
      }
      {
        action = ''<cmd>lua require("ufo").closeAllFolds()'';
        key = "zM";
        mode = "n";
        options.desc = "Close all folds";
      }
      {
        action = ''<cmd>lua require("ufo").peekFoldedLinesUnderCursor()'';
        key = "zK";
        mode = "n";
        options.desc = "Preview folded lines";
      }
      {
        action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
        key = "<leader><leader>c";
        mode = "n";
        options.desc = "Colorschemes";
      }
      {
        action = "<cmd>lua Snacks.picker.command_history<CR>";
        key = "<leader>cd";
        mode = "n";
        options.desc = "Commands history";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        key = "<leader>bb";
        mode = "n";
        options.desc = "Show buffers";
      }
      {
        action = "<cmd>lua Snacks.bufdelete.delete()<CR>";
        key = "<leader>bd";
        mode = "n";
        options = {
          desc = "Delete current buffer";
          silent = true;
        };
      }
      {
        action = "<cmd>lua Snacks.bufdelete.all()<CR>";
        key = "<leader>bD";
        mode = "n";
        options = {
          desc = "Delete all buffers";
          silent = true;
        };
      }
      {
        action = "<cmd>CBd<cr>";
        key = "<leader>uu";
        mode = "n";
        options.desc = "Comment";
      }
      {
        action = "<cmd>CBccbox<cr>";
        key = "<leader>ub";
        mode = "n";
        options.desc = "Comment with box";
      }
      {
        action = "<cmd>CBline<cr>";
        key = "<leader>ul";
        mode = "n";
        options.desc = "Comment simple line";
      }
      {
        action = "<cmd>CBllline<cr>";
        key = "<leader>ut";
        mode = "n";
        options.desc = "Comment with line";
      }
      {
        action = "<cmd>lua Snacks.picker.smart()<cr>";
        key = "<leader>ff";
        mode = "n";
        options.desc = "Search files by name";
      }
      {
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        key = "<leader>fg";
        mode = "n";
        options.desc = "Search files by contents";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "<leader>dj";
        mode = "n";
        options.desc = "Go to next diagnostic";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "<leader>dk";
        mode = "n";
        options.desc = "Go to previous diagnostic";
      }
      {
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        key = "<leader>dl";
        mode = "n";
        options.desc = "Show diagnostic details";
      }
      {
        action = "<cmd>Trouble diagnostics toggle<CR>";
        key = "<leader>dt";
        mode = "n";
        options.desc = "Toggle diagnostics list";
      }
      {
        action = "<Nop>";
        key = "<F1>";
        mode = [
          "n"
          "i"
          "v"
          "x"
          "s"
          "o"
          "t"
          "c"
        ];
        options.desc = "Disable accidental F1 help";
      }
      {
        action.__raw = ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        mode = [
          "n"
          "x"
        ];
        key = "<leader>cF";
        options.desc = "Format Injected Langs";
      }
      {
        action = "<cmd>lua Snacks.words.jump(1, true)<CR>";
        key = "]]";
        mode = [
          "n"
          "t"
        ];
        options.desc = "Next word reference";
      }
      {
        action = "<cmd>lua Snacks.words.jump(-1, true)<CR>";
        key = "[[";
        mode = [
          "n"
          "t"
        ];
        options.desc = "Previous word reference";
      }
      {
        action = "<cmd>lua Snacks.zen()<CR>";
        key = "<leader>z";
        mode = [ "n" ];
        options.desc = "Toggle zen mode";
      }
      {
        action = "<cmd>lua Snacks.zen.zoom()<CR>";
        key = "<leader>Z";
        mode = [ "n" ];
        options.desc = "Toggle zoom";
      }
    ];

    plugins.which-key = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        preset = "helix";
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "buffer";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "debug";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "file/find";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "git";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "quit/session";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "search";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "toggle";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "ui";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "g";
            group = "goto";
            mode = [
              "n"
              "x"
            ];
          }
          {
            __unkeyed-1 = "gs";
            group = "surround";
            mode = [
              "n"
              "x"
            ];
          }
        ];
      };
    };
  };
}

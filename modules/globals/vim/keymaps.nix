{
  den.default.os.programs.nixvim = {
    plugins.which-key = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
      settings = {
        preset = "modern";
        spec =
          [
            "n"
            "x"
          ]
          |> (mode: [
            {
              __unkeyed-1 = "<leader>a";
              group = "ai";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>b";
              group = "buffer";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "code/diagnostics";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>d";
              group = "debug";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>f";
              group = "file/find";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>m";
              group = "multicursor";
              inherit mode;
            }

            {
              __unkeyed-1 = "<leader>q";
              group = "quit/session";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>t";
              group = "toggle";
              inherit mode;
            }
            {
              __unkeyed-1 = "<leader>v";
              group = "preview";
              inherit mode;
            }
          ]);
      };
    };

    keymaps =
      {
        not-insert = [
          "n"
          "x"
          "o"
        ];
        normal-visual = [
          "n"
          "v"
        ];
      }
      |> (modes: [

        # ============================ QUIT / SESSION  ============================

        {
          action = "<cmd>quitall<CR><esc>";
          key = "<leader>qq";
          mode = "n";
          options.desc = "Quit all";
        }
        {
          action.__raw = ''
            function()
              vim.cmd("Neotree close")
              vim.cmd("Neominimap Toggle")
              vim.cmd("silent! %bd!")
              Snacks.dashboard()
            end
          '';
          key = "<leader>qa";
          mode = "n";
          options.desc = "Close all buffers and go to dashboard";
        }

        # ============================ MISC FUNCTION KEYS ============================

        {
          action = "<cmd>lua Snacks.zen()<CR>";
          key = "<leader><F3>";
          mode = "n";
          options.desc = "Toggle zen mode";
        }
        {
          action = "<cmd>lua Snacks.zen.zoom()<CR>";
          key = "<leader><F4>";
          mode = "n";
          options.desc = "Toggle zoom";
        }
        {
          action = "<cmd>CompilerOpen<CR>";
          key = "<leader><F5>";
          mode = "n";
          options.desc = "Compiler open";
        }
        {
          action = "<cmd>CompilerStop<CR>";
          key = "<leader><F6>";
          mode = "n";
          options.desc = "Compiler stop";
        }
        {
          action = "<cmd>CompilerToggleResults<CR>";
          key = "<leader><F7>";
          mode = "n";
          options.desc = "Compiler toggle results";
        }
        {
          action = "<cmd>IncRename<CR>";
          key = "<leader><F8>";
          mode = "n";
          options.desc = "IncRename";
        }
        {
          action = ''<cmd>lua require("actions-preview").code_actions()<CR>'';
          key = "<leader><F9>";
          mode = "n";
          options.desc = "Actions preview";
        }
        {
          action = ''<cmd>lua require("ufo").openAllFolds()<CR>'';
          key = "<leader><F10>";
          mode = "n";
          options.desc = "Open all folds";
        }
        {
          action = ''<cmd>lua require("ufo").closeAllFolds()<CR>'';
          key = "<leader><F11>";
          mode = "n";
          options.desc = "Close all folds";
        }
        {
          action = ''<cmd>lua require("ufo").peekFoldedLinesUnderCursor()<CR>'';
          key = "<leader><F12>";
          mode = "n";
          options.desc = "Preview folded lines";
        }

        # ============================ BUFFERS ============================

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
          options.desc = "Delete current buffer";
        }
        {
          action = "<cmd>Neominimap Focus<CR>";
          key = "<leader>bm";
          mode = "n";
          options.desc = "Neominimap Focus";
        }
        {
          action = "<cmd>Neotree Focus<CR>";
          key = "<leader>bn";
          mode = "n";
          options.desc = "Neominimap Focus";
        }
        {
          action = "<cmd>BufferLineCyclePrev<CR>";
          key = "<leader>b[";
          mode = "n";
          options.desc = "Previous buffer";
        }
        {
          action = "<cmd>BufferLineCycleNext<CR>";
          key = "<leader>b]";
          mode = "n";
          options.desc = "Next buffer";
        }
        {
          action = "<cmd>bdelete<CR>";
          key = "<leader>bc";
          mode = "n";
          options.desc = "Delete split";
        }
        {
          action = "<cmd>vnew<CR>";
          key = "<leader>bv";
          mode = "n";
          options.desc = "Vertical split";
        }
        {
          action = "<cmd>lua Snacks.bufdelete.all()<CR>";
          key = "<leader>bD";
          mode = "n";
          options.desc = "Delete all buffers";
        }

        # ============================ TOGGLE ============================

        {
          action = "<cmd>lua Snacks.terminal()<CR>";
          key = "<leader>tt";
          mode = "n";
          options.desc = "Toggle Terminal";
        }
        {
          action = "<cmd>Neominimap Toggle<CR>";
          key = "<leader>tm";
          mode = "n";
          options.desc = "Neominimap Toggle";
        }
        {
          action = "<cmd>Neotree toggle<CR>";
          key = "<leader>tn";
          mode = "n";
          options.desc = "Neominimap Toggle";
        }
        {
          action = "<cmd>lua Snacks.lazygit()<CR>";
          key = "<leader>tg";
          mode = "n";
          options.desc = "LazyGit";
        }
        {
          action = "<cmd>DiffviewOpen<CR>";
          key = "<leader>td";
          mode = "n";
          options.desc = "Diff view";
        }
        {
          action = "<cmd>DiffviewClose<CR>";
          key = "<leader>tD";
          mode = "n";
          options.desc = "Close diff view";
        }
        {
          action = "<cmd>UndotreeToggle<CR>";
          key = "<leader>tu";
          mode = "n";
          options.desc = "UndoTree";
        }
        {
          action = "<cmd>Navbuddy<CR>";
          key = "<leader>tv";
          mode = "n";
          options.desc = "Open up navbuddy";
        }
        {
          action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
          key = "<leader>tc";
          mode = "n";
          options.desc = "Colorschemes";
        }
        {
          action = "<cmd>lua Snacks.picker.command_history<CR>";
          key = "<leader>th";
          mode = "n";
          options.desc = "Commands history";
        }

        # ============================ FILES/FIND ============================

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
          action = "<cmd>GrugFar<CR>";
          key = "<leader>fs";
          mode = modes.normal-visual;
          options.desc = "GrugFar";
        }
        {
          action.__raw = "function() return require('grug-far').open({ prefills = { search = vim.api.nvim_get_current_line() }; }) end";
          key = "<Leader>fr";
          mode = modes.normal-visual;
          options.desc = "GrugFar current line";
        }
        {
          action = ''<cmd>lua require("flash").jump()<CR>'';
          key = "<leader>fj";
          mode = modes.normal-visual;
          options.desc = "Flash Jump";
        }
        {
          action = ''<cmd>lua require("flash").treesitter()<CR>'';
          key = "<leader>fJ";
          mode = modes.not-insert;
          options.desc = "Flash Treesitter";
        }
        {
          action = ''<cmd>lua require("flash").remote()<CR>'';
          key = "<leader>fr";
          mode = modes.not-insert;
          options.desc = "Flash Remote";
        }
        {
          action = ''<cmd>lua require("flash").treesitter_search()<CR>'';
          key = "<leader>fR";
          mode = modes.not-insert;
          options.desc = "Flash Treesitter Search";
        }
        {
          action = ''<cmd>lua require("flash").toggle()<CR>'';
          key = "<leader>ft";
          mode = [ "n" ];
          options.desc = "Flash Toggle";
        }

        # ============================ CODE / DIAGNOSTICS ============================

        {
          action = "<cmd>Trouble symbols toggle focus=false<CR>";
          key = "<leader>cs";
          mode = "n";
          options.desc = "Trouble symbols";
        }
        {
          action = "<cmd>Trouble diagnostics toggle<cr>";
          key = "<leader>cx";
          mode = "n";
          options.desc = "Diagnostics (Trouble)";
        }
        {
          action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
          key = "<leader>cX";
          mode = "n";
          options.desc = "Buffer Diagnostics (Trouble)";
        }
        {
          action = "<cmd>lua Snacks.words.jump(1, true)<CR>";
          key = "<leader>c]";
          mode = [
            "n"
            "t"
          ];
          options.desc = "Next word reference";
        }
        {
          action = "<cmd>lua Snacks.words.jump(-1, true)<CR>";
          key = "<leader>c[";
          mode = [
            "n"
            "t"
          ];
          options.desc = "Previous word reference";
        }
        {
          action = ''<cmd>lua require("nvim-toggler").toggle<CR>'';
          key = "<leader>c.";
          mode = "n";
          options.desc = "Toggle";
        }
        {
          action.__raw = ''function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end'';
          key = "<leader>cf";
          mode = [
            "n"
            "x"
          ];
          options.desc = "Format Injected Langs";
        }
        {
          action = "<cmd>AerialToggle!<CR>";
          key = "<leader>ct";
          mode = "n";
          options.desc = "Aerial toggle";
        }
        {
          action = "<cmd>AerialOpen!<CR>";
          key = "<leader>co";
          mode = "n";
          options.desc = "Aerial open";
        }
        {
          action = "<cmd>AerialClose<CR>";
          key = "<leader>co";
          mode = "n";
          options.desc = "Aerial close";
        }
        {
          action = "<cmd>AerialPrev<CR>";
          key = "<leader>c(";
          mode = "n";
          options.desc = "Aerial Prev";
        }
        {
          action = "<cmd>AerialNext<CR>";
          key = "<leader>c)";
          mode = "n";
          options.desc = "Aerial Next";
        }
        {
          action = "<cmd>CBd<cr>";
          key = "<leader>cu";
          mode = "n";
          options.desc = "Comment";
        }
        {
          action = "<cmd>CBccbox<cr>";
          key = "<leader>cb";
          mode = "n";
          options.desc = "Comment with box";
        }
        {
          action = "<cmd>CBline<cr>";
          key = "<leader>cl";
          mode = "n";
          options.desc = "Comment simple line";
        }
        {
          action = "<cmd>CBllline<cr>";
          key = "<leader>ch";
          mode = "n";
          options.desc = "Comment with line";
        }

        # ============================ LINES ============================

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

        # ============================ AI ============================

        {
          action = "<CMD>AvanteAsk<CR>";
          key = "<leader>ac";
          mode = "n";
          options.desc = "Avante ask";
        }
        {
          action = "<CMD>AvanteFocus<CR>";
          key = "<leader>af";
          mode = "n";
          options.desc = "Avante focus";
        }
        {
          action = "<CMD>AvanteClear<CR>";
          key = "<leader>ac";
          mode = "n";
          options.desc = "Avante clear";
        }
        {
          action = "<CMD>AvanteHistory<CR>";
          key = "<leader>ah";
          mode = "n";
          options.desc = "Avante history";
        }
        {
          action = "<CMD>AvanteNew<CR>";
          key = "<leader>an";
          mode = "n";
          options.desc = "Avante chat new";
        }
        {
          action = "<CMD>AvanteStop<CR>";
          key = "<leader>as";
          mode = "n";
          options.desc = "Avante stop";
        }
        {
          action = "<CMD>AvanteToggle<CR>";
          key = "<leader>at";
          mode = "n";
          options.desc = "Avante toggle";
        }

        # ============================ PREVIEW ============================

        {
          action = "<cmd>lua require('goto-preview').close_all_win()<CR>";
          key = "<leader>vc";
          mode = "n";
          options.desc = "Preview Close Wins";
        }
        {
          action = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>";
          key = "<leader>vd";
          mode = "n";
          options.desc = "Preview Definition";
        }
        {
          action = "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>";
          key = "<leader>vt";
          mode = "n";
          options.desc = "Preview Type Definition";
        }
        {
          action = "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>";
          key = "<leader>vi";
          mode = "n";
          options.desc = "Preview Implementation";
        }
        {
          action = "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>";
          key = "<leader>vD";
          mode = "n";
          options.desc = "Preview Declaration";
        }
        {
          action = "<cmd>lua require('goto-preview').goto_preview_references()<CR>";
          key = "<leader>vr";
          mode = "n";
          options.desc = "Preview Declaration";
        }

        # ============================ MULTICURSOR ============================

        {
          action = "<cmd>lua require('multicursor-nvim').matchAddCursor(1)<CR>";
          key = "<leader>mn";
          mode = modes.not-insert;
          options.desc = "Multi: Match Next";
        }
        {
          action = "<cmd>lua require('multicursor-nvim').matchAddCursor(-1)<CR>";
          key = "<leader>mp";
          mode = modes.not-insert;
          options.desc = "Multi: Match Prev";
        }
        {
          action = "<cmd>lua require('multicursor-nvim').matchSkipCursor(1)<CR>";
          key = "<leader>ms";
          mode = modes.not-insert;
          options.desc = "Multi: Match Skip";
        }
        {
          action = "<cmd>lua require('multicursor-nvim').matchAllAddCursors()<CR>";
          key = "<leader>ma";
          mode = modes.not-insert;
          options.desc = "Multi: Match All";
        }
        {
          action = "<cmd>lua require('multicursor-nvim').lineAddCursor(-1)<CR>";
          key = "<leader>m<up>";
          mode = modes.not-insert;
          options.desc = "Multi: Add Line Above";
        }
        {
          action = "<cmd>lua require('multicursor-nvim').lineAddCursor(1)<CR>";
          key = "<leader>m<down>";
          mode = modes.not-insert;
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

        # ============================ YANKY ============================

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
          mode = modes.not-insert;
          options.desc = "Open Yank History";
        }
        {
          action = "<Plug>(YankyYank)";
          key = "y";
          mode = modes.not-insert;
          options.desc = "Yank";
        }
        {
          action = "<Plug>(YankyPutAfter)";
          key = "p";
          mode = modes.not-insert;
          options.desc = "Yanky Put after";
        }
        {
          action = "<Plug>(YankyPutBefore)";
          key = "P";
          mode = modes.not-insert;
          options.desc = "Put before";
        }
        {
          action = "<Plug>(YankyGPutAfter)";
          key = "gp";
          mode = modes.not-insert;
          options.desc = "Yanky Put after selection";
        }
        {
          action = "<Plug>(YankyGPutBefore)";
          key = "gP";
          mode = modes.not-insert;
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

        # ============================ DEBUG ============================

        {
          action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
          key = "<leader>dB";
          mode = "n";
          options.desc = "Breakpoint condition";
        }
        {
          action = ":DapToggleBreakpoint<CR>";
          key = "<leader>db";
          mode = "n";
          options.desc = "Toggle breakpoint";
        }
        {
          action = ":DapContinue<CR>";
          key = "<leader>dc";
          mode = "n";
          options.desc = "Continue";
        }
        {
          action = "<cmd>lua require('dap').continue({ before = get_args })<CR>";
          key = "<leader>da";
          mode = "n";
          options.desc = "Run with args";
        }
        {
          action = "<cmd>lua require('dap').run_to_cursor()<CR>";
          key = "<leader>dC";
          mode = "n";
          options.desc = "Run to cursor";
        }
        {
          action = "<cmd>lua require('dap').goto_()<CR>";
          key = "<leader>dg";
          mode = "n";
          options.desc = "Go to line (no execute)";
        }
        {
          action = ":DapStepInto<CR>";
          key = "<leader>di";
          mode = "n";
          options.desc = "Step into";
        }
        {
          action = "<cmd>lua require('dap').down()<CR>";
          key = "<leader>dj";
          mode = "n";
          options.desc = "Down";
        }
        {
          action = "<cmd>lua require('dap').up()<CR>";
          key = "<leader>dk";
          mode = "n";
          options.desc = "Up";
        }
        {
          action = "<cmd>lua require('dap').run_last()<CR>";
          key = "<leader>dl";
          mode = "n";
          options.desc = "Run last";
        }
        {
          action = ":DapStepOut<CR>";
          key = "<leader>do";
          mode = "n";
          options.desc = "Step out";
        }
        {
          action = ":DapStepOver<CR>";
          key = "<leader>dO";
          mode = "n";
          options.desc = "Step over";
        }
        {
          action = "<cmd>lua require('dap').pause()<CR>";
          key = "<leader>dp";
          mode = "n";
          options.desc = "Pause";
        }
        {
          action = ":DapToggleRepl<CR>";
          key = "<leader>dr";
          mode = "n";
          options.desc = "Toggle REPL";
        }
        {
          action = "<cmd>lua require('dap').session()<CR>";
          key = "<leader>ds";
          mode = "n";
          options.desc = "Session";
        }
        {
          action = ":DapTerminate<CR>";
          key = "<leader>dt";
          mode = "n";
          options.desc = "Terminate";
        }
        {
          action = "<cmd>lua require('dapui').toggle()<CR>";
          key = "<leader>du";
          mode = "n";
          options.desc = "Dap UI";
        }
        {
          action = "<cmd>lua require('dap.ui.widgets').hover()<CR>";
          key = "<leader>dw";
          mode = "n";
          options.desc = "Widgets";
        }
        {
          action = "<cmd>lua require('dapui').eval()<CR>";
          key = "<leader>de";
          mode = modes.not-insert;
          options.desc = "Eval";
        }
      ]);
  };
}

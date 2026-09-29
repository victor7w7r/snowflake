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
        key = "<leader>pc";
        action = "<cmd>lua require('goto-preview').close_all_win()<CR>";
        options.desc = "Preview Close Wins";
      }
      {
        mode = "n";
        key = "<leader>pd";
        action = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>";
        options.desc = "Preview Definition";
      }
      {
        mode = "n";
        key = "<leader>pt";
        action = "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>";
        options.desc = "Preview Type Definition";
      }
      {
        mode = "n";
        key = "<leader>pi";
        action = "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>";
        options.desc = "Preview Implementation";
      }
      {
        mode = "n";
        key = "<leader>pD";
        action = "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>";
        options.desc = "Preview Declaration";
      }
      {
        mode = "n";
        key = "<leader>pr";
        action = "<cmd>lua require('goto-preview').goto_preview_references()<CR>";
        options.desc = "Preview Declaration";
      }
      {
        action = "<cmd>Neominimap Toggle<CR>";
        key = "<leader>tm";
        mode = "n";
        options.desc = "Neominimap Toggle";
      }
      {
        action = "<cmd>Neominimap Refresh<CR>";
        key = "<leader>mr";
        mode = "n";
        options.desc = "Neominimap Refresh";
      }
      {
        action = "<cmd>Neominimap Focus<CR>";
        key = "<leader>mf";
        mode = "n";
        options.desc = "Neominimap Focus";
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

{
  den.default.os.programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>m .+1<cr>==";
        key = "<A-j>";
        mode = "n";
        options.desc = "Move line down";
      }
      {
        action = "<cmd>m .-2<cr>==";
        key = "<A-k>";
        mode = "n";
        options.desc = "Move line up";
      }
      {
        action = "<cmd>m .+1<cr>==";
        key = "<A-Down>";
        mode = "n";
        options.desc = "Move line down";
      }
      {
        action = "<cmd>m .-2<cr>==";
        key = "<A-Up>";
        mode = "n";
        options.desc = "Move line up";
      }
      {
        action = ":m '>+1<cr>gv=gv";
        key = "<A-j>";
        mode = "x";
        options.desc = "Mover selección abajo";
      }
      {
        action = ":m '>+1<cr>gv=gv";
        key = "<A-Down>";
        mode = "x";
        options.desc = "Mover selección abajo";
      }
      {
        action = ":m '<-2<cr>gv=gv";
        key = "<A-k>";
        mode = "x";
        options.desc = "Mover selección arriba";
      }
      {
        action = ":m '<-2<cr>gv=gv";
        key = "<A-Up>";
        mode = "x";
        options.desc = "Mover selección arriba";
      }
      {
        action = ":t '><cr>";
        key = "<S-A-Down>";
        mode = "x";
        options.desc = "Duplicate selected lines down";
      }
      {
        action = ":t '><cr>";
        key = "<A-S-j>";
        mode = "x";
        options.desc = "Duplicate selected lines down";
      }
      {
        action = "<cmd>t .<cr>";
        key = "<S-A-Down>";
        mode = "n";
        options.desc = "Duplicate line down";
      }
      {
        action = "<cmd>t .<cr>";
        key = "<A-S-j>";
        mode = "n";
        options.desc = "Duplicate line down";
      }
      {
        action = "<cmd>quitall<cr><esc>";
        key = "<leader>qq";
        mode = "n";
        options = {
          desc = "Quit all";
          silent = true;
        };
      }
      {
        action = "<CMD>vnew<CR>";
        key = "<leader>sn";
        mode = "n";
        options.desc = "Vertical Split";
      }
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>tn";
        mode = "n";
        options.desc = "Toggle neotree";
      }
      {
        action = "<cmd>ToggleTerm<CR>";
        key = "<leader>tt";
        mode = "n";
        options.desc = "Toggle terminal";
      }
      {
        action = "<cmd>LazyGit<CR>";
        key = "<leader>gg";
        mode = "n";
        options.desc = "LazyGit";
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
        action.__raw = "function() mc.matchAddCursor(1) end";
        key = "<leader>n";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Add next cursor";
      }
      {
        action.__raw = "function() mc.matchSkipCursor(1) end";
        key = "<leader>v";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Jump to the other cursor";
      }
      {
        action.__raw = "function() mc.matchAddCursor(-1) end";
        key = "<leader>N";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Add previous cursor";
      }
      {
        action.__raw = "function() mc.matchSkipCursor(-1) end";
        key = "<leader>V";
        mode = [
          "n"
          "x"
        ];
        options.desc = "Jump to the previous cursor";
      }
      {
        action = "<cmd>Telescope colorscheme<CR>";
        key = "<leader><leader>c";
        mode = "n";
        options.desc = "Colorscheme telescope";
      }
      {
        action = "<cmd>Telescope commands<CR>";
        key = "<leader>cd";
        mode = "n";
        options.desc = "Display telescope";
      }
      {
        action = "<cmd>Telescope buffers<cr>";
        key = "<leader>bb";
        mode = "n";
        options.desc = "Show buffers";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua Snacks.bufdelete.delete()<CR>";
        options = {
          desc = "Delete current buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>lua Snacks.bufdelete.all()<CR>";
        options = {
          desc = "Delete all buffers";
          silent = true;
        };
      }
      {
        action = "<cmd>Telescope find_files<cr>";
        key = "<leader>ff";
        mode = "n";
        options.desc = "Search files by name";
      }
      {
        action = "<cmd>Telescope live_grep<cr>";
        key = "<leader>lg";
        mode = "n";
        options.desc = "Search files by contents";
      }
      {
        action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        key = "<leader>.";
        mode = "n";
        options.desc = "Comment line";
      }
      {
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        key = "<leader>.";
        mode = "v";
        options.desc = "Comment selection";
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
        mode = "n";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        key = "<leader>dl";
        options.desc = "Show diagnostic details";
      }
      {
        action = "<cmd>Trouble diagnostics toggle<cr>";
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
    ];

    plugins.which-key = {
      enable = true;
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

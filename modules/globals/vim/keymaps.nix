{
  den.default.os.programs.nixvim = {
    keymaps = [
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
        action = "<cmd>lua function() Snacks.scratch() end<CR>";
        key = "<leader>.";
        mode = "n";
        options.desc = "Toggle scratch";
      }
      {
        action = "<cmd>lua function() Snacks.scratch.select() end<CR>";
        key = "<leader>,";
        mode = "n";
        options.desc = "Select scratch";
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
        action = "<cmd>lua Snacks.terminal()<CR>";
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
        action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
        key = "<leader><leader>c";
        mode = "n";
        options.desc = "Colorschemes";
      }
      {
        action = "<cmd>lua Snacks.picker.command_historyCR>";
        key = "<leader>cd";
        mode = "n";
        options.desc = "Commands history";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
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
      {
        mode = [
          "n"
          "t"
        ];
        key = "]]";
        action = "<cmd>lua Snacks.words.jump(1, true)<CR>";
        options.desc = "Next word reference";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "[[";
        action = "<cmd>lua Snacks.words.jump(-1, true)<CR>";
        options.desc = "Previous word reference";
      }
      {
        key = "<leader>z";
        mode = [ "n" ];
        action = "<cmd>lua Snacks.zen()<CR>";
        options.desc = "Toggle zen mode";
      }
      {
        key = "<leader>Z";
        mode = [ "n" ];
        action = "<cmd>lua Snacks.zen.zoom()<CR>";
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

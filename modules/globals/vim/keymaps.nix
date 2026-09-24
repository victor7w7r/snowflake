{
  den.default.os.programs.nixvim.keymaps = [
    {
      action = "<ESC>";
      key = "jk";
      mode = "i";
      options.desc = "Exit insert mode";
    }
    {
      action = "<cmd>Neotree toggle<cr>";
      key = "<leader>fe";
      mode = "n";
      options.desc = "File browser toggle";
    }
    {
      action = "<cmd>LazyGit<CR>";
      key = "<leader>gg";
      mode = "n";
      options.desc = "LazyGit (root dir)";
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
      action = "<cmd>ToggleTerm<CR>";
      key = "<leader>t";
      mode = "n";
      options.desc = "Toggle terminal";
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
      action = ":help<Space>";
      key = "<leader>h";
      mode = "n";
      options = {
        desc = "Open :help prompt";
        nowait = true;
      };
    }
    {
      action = ":help <C-r><C-w><CR>";
      key = "<leader>H";
      mode = "n";
      options.desc = "Help for word under cursor";
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
}

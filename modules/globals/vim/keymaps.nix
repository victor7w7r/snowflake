{
  den.default.os.programs.nixvim.keymaps = [
    {
      action = "<ESC>";
      key = "jk";
      mode = "i";
      options.desc = "Exit insert mode";
    }
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>ft";
      mode = "n";
      options.desc = "Toggle neotree";
    }
    {
      action = "<cmd>ToggleTerm<CR>";
      key = "<leader>t";
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
      action = "<cmd>lua MiniMap.toggle_focus()<CR>";
      key = "<Leader>mf";
      mode = "n";
      options.desc = "Minimap focus";
    }
    {
      action = "<cmd>lua MiniMap.toggle()<CR>";
      key = "<Leader>mt";
      mode = "n";
      options.desc = "Minimap toggle";
    }
    {
      action = "<cmd>lua MiniMap.refresh()<CR>";
      key = "<Leader>mr";
      mode = "n";
      options.desc = "Minimap refresh";
    }
    {
      action = "<cmd>lua MiniMap.toggle_side()<CR>";
      key = "<Leader>ms";
      mode = "n";
      options.desc = "Minimap toggle side";
    }
    {
      key = "<leader><leader>c";
      action = "<cmd>Telescope colorscheme<CR>";
      mode = "n";
      options.desc = "Colorscheme telescope";
    }
    {
      key = "<leader>cd";
      mode = "n";
      action = "<cmd>Telescope commands<CR>";
      options.desc = "Display telescope";
    }
    {
      action = "<cmd>Telescope buffers<cr>";
      key = "<leader>bb";
      mode = "n";
      options.desc = "Show buffers";
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
}

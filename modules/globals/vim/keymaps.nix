{
  den.default.os.programs.nixvim.keymaps = [
    {
      key = "jk";
      mode = [ "i" ];
      action = "<ESC>";
      options.desc = "Exit insert mode";
    }
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Search files by name";
    }
    {
      key = "<leader>lg";
      mode = [ "n" ];
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Search files by contents";
    }
    {
      key = "<leader>fe";
      mode = [ "n" ];
      action = "<cmd>Neotree toggle<cr>";
      options.desc = "File browser toggle";
    }
    {
      key = "<leader>t";
      mode = [ "n" ];
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      key = "<leader>.";
      mode = [ "n" ];
      action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
      options.desc = "Comment line";
    }
    {
      key = "<leader>.";
      mode = [ "v" ];
      action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
      options.desc = "Comment selection";
    }
    {
      key = "<leader>dj";
      mode = [ "n" ];
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      options.desc = "Go to next diagnostic";
    }
    {
      key = "<leader>dk";
      mode = [ "n" ];
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      options.desc = "Go to previous diagnostic";
    }
    {
      key = "<leader>dl";
      mode = [ "n" ];
      action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      options.desc = "Show diagnostic details";
    }
    {
      key = "<leader>dt";
      mode = [ "n" ];
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Toggle diagnostics list";
    }
    {
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
      action = "<Nop>";
      options.desc = "Disable accidental F1 help";
    }
    {
      key = "<leader>h";
      mode = [ "n" ];
      action = ":help<Space>";
      options = {
        desc = "Open :help prompt";
        nowait = true;
      };
    }
    {
      key = "<leader>H";
      mode = [ "n" ];
      action = ":help <C-r><C-w><CR>";
      options.desc = "Help for word under cursor";
    }
  ];
}

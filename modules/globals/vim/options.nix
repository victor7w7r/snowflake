{
  den.default.os.programs.nixvim = {
    globals = {
      autoformat = true;
      markdown_recommended_style = 0;
    };

    clipboard = {
      providers = {
        wl-copy.enable = true;
        xsel.enable = true;
      };
      register = "unnamedplus";
    };

    opts = {
      autowrite = true;
      breakindent = true;
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      foldmethod = "indent";
      foldlevel = 99;
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";
      linebreak = true;
      ignorecase = true;
      mouse = "a";
      pumblend = 10;
      pumheight = 10;
      number = true;
      relativenumber = false;
      ruler = false;
      showmode = false;
      sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds";
      signcolumn = "yes";
      smartcase = true;
      shiftwidth = 2;
      smoothscroll = false;
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 250;
      winborder = "rounded";
      winminwidth = 5;
      wrap = false;
    };
  };
}

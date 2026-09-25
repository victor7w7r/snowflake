{
  den.default.os.programs.nixvim = {
    globals = {
      autoformat = true;
      mapleader = " ";
      maplocalleader = " ";
      markdown_recommended_style = 0;
    };

    diagnostic.settings = {
      virtual_text = true;
      severity_sort = true;
      float.border = "rounded";
    };

    plugins = {
      lz-n.enable = true;
      lzn-auto-require.enable = true;
      sqlite-lua.enable = true;
    };

    performance.byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      configs = true;
      plugins = true;
    };

    opts = {
      autoindent = true;
      autowrite = true;
      autoread = true;
      backup = false;
      background = "dark";
      breakindent = true;
      completeopt = [
        "menuone"
        "noselect"
        "noinsert"
      ];
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      encoding = "utf-8";
      errorbells = false;
      expandtab = true;
      fileencoding = "utf-8";
      foldcolumn = "0";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      foldmethod = "indent";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      guicursor = "n-v-c:block-blinkon200-blinkoff200";
      hidden = true;
      hlsearch = true;
      ignorecase = true;
      incsearch = true;
      linebreak = true;
      mouse = "a";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = false;
      sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds";
      shiftwidth = 2;
      showmode = false;
      showtabline = 0;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smoothscroll = false;
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      swapfile = false;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 250;
      visualbell = false;
      wildmenu = true;
      wildmode = "longest,list,full";
      winborder = "rounded";
      winminwidth = 5;
      wrap = false;
    };
  };
}

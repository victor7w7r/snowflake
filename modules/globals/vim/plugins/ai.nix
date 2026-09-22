{
  den.default.os.programs.nixvim.plugins = {
    copilot-chat = {
      enable = true;
    };

    copilot-lua = {
      enable = true;
      settings = {
        suggestion.enabled = false;
        panel.enabled = false;
        filetypes = {
          yaml = false;
          markdown = false;
          help = false;
          gleam = false;
          gitcommit = false;
          gitrebase = false;
          hgcommit = false;
          svn = false;
          cvs = false;
          "." = false;
        };
      };
    };
  };
}

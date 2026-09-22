{
  den.default.os.programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enable = true;
      bufdelete.enable = true;
      explorer = { enabled = true; replace_netrw = true; };
      git.enable = true;
      gitbrowse.enable = true;
      image.enable = true;
      indent.enabled = true;
      input.enabled = true;
      lazygit.enable = true;
      picker = { enabled = true; layout.preset = "telescope"; };
      quickfile.enabled = true;
      scope.enable = true;
      scroll.enabled = false;
      terminal.enable = true;
    };
  };

  /*
    plugins = {
    snacks = {
      enable = true;
      settings = {
        statuscolumn.enable = true;
        words.enable = true;
        notifier.enable = true;
        scratch.enable = true;
        debug.enable = true;
        indent.enable = true;
        picker = {
          enable = true;
          layout = "vertical";
          actions = {
            cd_up.__raw = ''
              function(picker)
                picker:set_cwd(vim.fs.dirname(picker:cwd()))
                picker:find()
              end
            '';
          };

          };
  */
}

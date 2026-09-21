{
  den.default.os.programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      indent.enabled = true;
      input.enabled = true;
      scroll.enabled = false;
    };
  };

  /*   plugins = {
     snacks = {
       enable = true;
       settings = {
         scope.enable = true;
         statuscolumn.enable = true;
         words.enable = true;
         bufdelete.enable = true;
         bigfile.enable = true;
         notifier.enable = true;
         lazygit.enable = true;
         gitbrowse.enable = true;
         gh.enable = true;
         git.enable = true;
         scratch.enable = true;
         debug.enable = true;
         terminal.enable = true;
         image.enable = true;
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

           };*/
}

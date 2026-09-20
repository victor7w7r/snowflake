{
  den.default.os.programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "hyper";
      config = {
        mru.limit = 10;
        header = [
          ""
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ""
        ];
        shortcut = [
          {
            desc = " Files";
            key = "f";
            action = "FzfLua files";
          }
          {
            desc = " Recent";
            key = "r";
            action = "FzfLua oldfiles";
          }
          {
            desc = " Explorer";
            key = "e";
            action = "Neotree";
          }
        ];
      };
    };
  };
}

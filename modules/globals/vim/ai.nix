{ den, ... }: {
  den.default = {
    #includes = [ (den.batteries.unfree [ "copilot-language-server" ]) ];

    os.programs.nixvim.plugins = {

    };
  };
}

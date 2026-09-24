{ den, ... }: {
  den.default = {
    os.programs.nixvim.plugins = {
      avante.enable = true;
      blink-cmp-avante.enable = true;
    };
  };
}

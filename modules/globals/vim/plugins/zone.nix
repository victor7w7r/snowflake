{ inputs, ... }:{
  flake-file.inputs.zone-nvim = {
    url = "github:tamton-aquib/zone.nvim";
    flake = false;
  };

  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "tamton-aquib";
          src = inputs.zone-nvim;
        })
      ];

      extraConfigLua = ''
        require('early-retirement').setup({})
      '';
    };
  };
}

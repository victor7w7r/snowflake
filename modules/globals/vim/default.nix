{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.default = {
    os = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];
      programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
      };
    };
  };
}

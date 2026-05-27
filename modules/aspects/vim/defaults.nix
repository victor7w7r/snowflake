{ lib, inputs, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.vim = {
    imports = [ inputs.nixvim.nixosModules.nixvim ];
    nixos =
      { user, ... }:
      {
        environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [ ".cache/nvim" ];
        programs.nixvim = {
          enable = true;
          colorschemes.catppuccin.enable = true;
          plugins.lualine.enable = true;
        };
      };
  };
}

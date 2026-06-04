{ lib, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.vim = {
    nixos =
      {
        isPersistent,
        inputs',
        user,
        ...
      }:
      lib.mkMerge [
        (lib.mkIf isPersistent {
          environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [ ".cache/nvim" ];
        })
        {
          imports = [ inputs'.nixvim.nixosModules.nixvim ];

          programs.nixvim = {
            enable = true;
            colorschemes.catppuccin.enable = true;
            plugins.lualine.enable = true;
          };
        }
      ];
  };
}

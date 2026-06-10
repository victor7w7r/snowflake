{ inputs, lib, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.vim = {

    os = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];

      programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
      };
    };

    nixos =
      { isPersistent, user, ... }:
      lib.optional isPersistent {
        environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [ ".cache/nvim" ];
      };
  };
}

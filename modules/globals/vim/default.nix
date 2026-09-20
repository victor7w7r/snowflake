{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.default.os = { pkgs, ... }: {
    imports = [ inputs.nixvim.nixosModules.nixvim ];
    programs.nixvim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      nixpkgs.source = inputs.nixpkgs;

      clipboard = {
        providers = {
          wl-copy.enable = true;
          xsel.enable = true;
        };
        register = "unnamedplus";
      };

      opts = {
        relativenumber = false;
        smoothscroll = false;
      };
    };
  };
}

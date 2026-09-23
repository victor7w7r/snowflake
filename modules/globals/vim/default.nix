{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.default.os = { pkgs, ... }: {
    imports = [ inputs.nixvim.nixosModules.nixvim ];
    programs.nixvim = {
      enable = true;
      nixpkgs = {
        config.allowUnfree = true;
        source = inputs.nixpkgs;
      };
      package = pkgs.neovim-unwrapped;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      withPython3 = false;
      withRuby = false;
      withNodeJs = false;

      extraPackages = with pkgs; [
        vscode-langservers-extracted
        typescript-language-server
        typescript
        pyright
        stylua
        shfmt
      ];
    };
  };
}

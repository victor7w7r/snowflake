{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.default.os = { pkgs, ... }: {
    imports = [ inputs.nixvim.nixosModules.nixvim ];
    programs.nixvim = {
      enable = true;
      nixpkgs.source = inputs.nixpkgs;
      package = pkgs.neovim-unwrapped;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      withPython3 = false;
      withRuby = false;
      withNodeJs = false;

      plugins.lz-n.enable = true;

      extraPackages = with pkgs; [
        hyprls
        vscode-langservers-extracted
        nodePackages.typescript-language-server
        nodePackages.typescript
        pyright
        stylua
        shfmt
      ];
    };
  };
}

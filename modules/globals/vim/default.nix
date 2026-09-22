{ inputs, ... }:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.default = {
    os = { pkgs, ... }: {
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

        plugins = {
          lz-n.enable = true;
          lzn-auto-require.enable = true;
        };

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
  };
}

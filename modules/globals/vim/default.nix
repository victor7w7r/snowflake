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

      clipboard = {
        providers = {
          wl-copy.enable = true;
          xsel.enable = true;
        };
        register = "unnamedplus";
      };

      extraPackages = with pkgs; [
        glab
        kotlin
        nixfmt
        pyright
        shfmt
        stylua
        luajitPackages.tree-sitter-cli
        typescript
        typescript-language-server
        vscode-langservers-extracted
      ];
    };
  };
}

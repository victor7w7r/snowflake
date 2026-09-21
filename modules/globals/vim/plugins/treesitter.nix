{
  den.default.os = { pkgs, ... }: {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        css
        diff
        html
        javascript
        json
        lua
        markdown
        markdown_inline
        nix
        python
        regex
        rust
        svelte
        tsx
        typescript
        vim
        vimdoc
        vue
        xml
        yaml
      ];
    };
  };
}

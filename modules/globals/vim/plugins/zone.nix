{
  den.default.os = { pkgs, ... }: {
    programs.nixvim = {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "nvim-early-retirement";
          src = pkgs.fetchFromGitHub {
            owner = "chrisgrieser";
            repo = "nvim-early-retirement";
            rev = "8ddd369731c3a123a062ccc75c5c9ed54ffec9c1";
            hash = "sha256-3GSe2H3wnnG+BD6fsLClMySUwxkMaG1lqX1mHbnmgwI=";
          };
        })
      ];

      extraConfigLua = ''
        require('early-retirement').setup({})
      '';
    };
  };
}

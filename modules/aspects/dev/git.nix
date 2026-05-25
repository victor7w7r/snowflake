{
  den.aspects.dev.provides.git = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          #github-copilot-cli
          #jan
          #ollama-rocm
          delta
          gh
          gh-dash
          git
          git-lfs
          git-extras
          hub
          zsh-forgit
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          git-credential-manager
          lazygit
        ];

        programs.git = {
          enable = true;
          lfs.enable = true;
          settings = {
            core.pager = "${pkgs.delta}/bin/delta";
            init.defaultBranch = "main";
            user = {
              name = "victor7w7r";
              email = "arkano036@gmail.com";
            };
            #credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
            delta = {
              hyperlinks = true;
              keep-plus-minus-markers = true;
              line-numbers = true;
              navigate = true;
              side-by-side = true;
              syntax-theme = "TwoDark";
              tabs = 4;
            };
            difftool.prompt = true;
            merge.conflictstyle = "diff3";
            mergetool.prompt = true;
            rebase.autostash = true;
            pull.rebase = true;
            push.autoSetupRemote = true;
            alias = {
              unstash = "stash pop";
              s = "status";
              tags = "tag -l";
              t = "tag -s -m ''";
              commit-reuse-message = ''!git commit --edit --file "$(git rev-parse --git-dir)"/COMMIT_EDITMSG'';
            };
          };
        };
      };
  };
}

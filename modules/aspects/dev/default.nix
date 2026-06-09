{
  den.aspects.dev.default = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          atac
          httpie
          dos2unix
          curlie
          fw
          jless
          just
          jwt-ui
          ktlint
          kyun
          loc
          mynav
          posting
          rainfrog
          shellcheck
          tracexec
          ugm
          updo
          xh
          #elia-chat
          #dblab
          #gobang
        ];

        programs.direnv = {
          enable = false;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
      };

    homeManager.programs = {
      #aichat.enable = true;
      #aider-chat.enable = true;
      #meli.enable = true; BUILD
      #visidata.enable = true;
      gitui.enable = true;
      jq.enable = true;
      lazysql.enable = true;
      mods.enable = true;
      pyenv = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
    };
  };
}

{ den, ... }:
{
  den.aspects.dev = {
    includes = with den.aspects.dev._; [
      ccache
      git
      mise
    ];

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
          ktlint
          posting
          rainfrog
          shellcheck
          tracexec
          xh
          #dblab
          #gobang
          /*
            (pkgs.callPackage ./custom/elia-chat.nix { })
            (pkgs.callPackage ./custom/gpterminator.nix { })
            (pkgs.callPackage ./custom/jwt-ui.nix { })
            (pkgs.callPackage ./custom/kyun.nix { })
            (pkgs.callPackage ./custom/loc.nix { })
            (pkgs.callPackage ./custom/mynav.nix { })
            (pkgs.callPackage ./custom/ugm.nix { })
            (pkgs.callPackage ./custom/updo.nix { })
          */
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
      gitui.enable = true;
      jq.enable = true;
      lazysql.enable = true;
      #meli.enable = true; BUILD
      mods.enable = true;
      pyenv = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
      #visidata.enable = true;
    };
  };
}

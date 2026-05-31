{ den, ... }:
{
  den.aspects.base = {
    includes = with den.aspects.base._; [
      coreutils
      disk-management
      locale
      nettools
      security
      starship
      shell
      tmux
    ];

    nixos =
      { pkgs, options, ... }:
      {
        environment = {
          enableAllTerminfo = true;
          pathsToLink = [ "/share/applications" ];
          sessionVariables.NIXOS_OZONE_WL = "1";
        };

        console = {
          packages = options.console.packages.default ++ [ pkgs.terminus_font ];
          keyMap = "us-acentos";
        };

        programs = {
          #bash.blesh.enable = true;
          gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
            pinentryPackage = pkgs.pinentry-tty;
          };
          pay-respects.enable = true;
          yazi = {
            enable = true;
            /*
              settings.manager = {
              show_hidden = true;
              show_symlink = true;
              };
            */
          };
          zsh.enable = true;
          less.enable = true;
          skim.enable = true;
        };
      };

    homeManager = {
      services.pueue.enable = true;
      programs = {
        #lsd.enable = true;
        tealdeer.enable = true;
        navi.enable = true;
        topgrade.enable = true;
        asciinema.enable = true;
        rtorrent.enable = true;
      };
    };
  };
}

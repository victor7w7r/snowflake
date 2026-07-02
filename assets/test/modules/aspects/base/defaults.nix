{ den, ... }:
{
  den.aspects.base = {
    includes = with den.aspects.base._; [
      coreutils
    ];

    nixos =
      { pkgs, modulesPath, ... }:
      {
        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

        environment = {
          enableAllTerminfo = true;
          pathsToLink = [ "/share/applications" ];
          sessionVariables = {
            LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
            NIXOS_OZONE_WL = "1";
          };
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

    provides.to-users.homeManager = {
      services.pueue.enable = true;
      programs = {
        #lsd.enable = true;
        bat = {
          enable = true;
          config = {
            pager = "less -FR";
            theme = "Dracula";
          };
        };

        eza = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          colors = "always";
          extraOptions = [
            "--group-directories-first"
            "--header"
            "--no-quotes"
          ];
        };

        pyenv = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          defaultOptions = [
            "--height 40%"
            "--reverse"
            "--border"
            "--color=16"
          ];
          defaultCommand = "rg --files --hidden --glob=!.git/";
        };

        tealdeer.enable = true;
        navi.enable = true;
        topgrade.enable = true;
        asciinema.enable = true;
        rtorrent.enable = true;

        zoxide = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          options = [ "--cmd cd" ];
        };
      };
    };
  };
}

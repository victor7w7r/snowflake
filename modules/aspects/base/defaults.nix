{
  den.aspects.base = {
    homeManager = {
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

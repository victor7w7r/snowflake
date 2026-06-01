{
  main-mac.system.nixos =
    {
      inputs,
      host,
      pkgs,
      user,
      ...
    }:
    {

      networking = {
        computerName = host;
        localHostName = host;
        hostName = host;
        applicationFirewall = {
          enable = true;
          blockAllIncoming = false;
          allowSigned = true;
          allowSignedApp = true;
          enableStealthMode = false;
        };
      };

      fonts.packages = with pkgs; [
        nerd-fonts.ubuntu
        nerd-fonts.ubuntu-mono
        nerd-fonts.jetbrains-mono
        noto-fonts-color-emoji
      ];

      programs = {
        #bandwhich.enable = true;
        #less.enable = true;
        #skim.enable = true;
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
        #bottom.enable = true;
        /*
          yazi = {
          enable = true;
          /*
            settings.manager = {
            show_hidden = true;
            show_symlink = true;
            };

            };
        */
      };

    };

}

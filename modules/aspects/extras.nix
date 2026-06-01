{ lib, ... }:
{
  den.aspects = {
    extras = {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            cheat
            cmd-wrapped
            emptty
            modprobed-db
            glow
            inotify-tools
            jump
            #sampler
            seadrive-fuse
            seafile-shared
            viddy
            vtm
            wtfutil
          ];
          programs.gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
            pinentryPackage = pkgs.pinentry-tty;
          };
        };

      homeManager = {
        services.pueue.enable = true;
        programs = {
          #lsd.enable = true;
          tealdeer.enable = true;
          bottom.enable = true;
          navi.enable = true;
          hwatch.enable = true;
          topgrade.enable = true;
          asciinema.enable = true;
          rtorrent.enable = true;
        };
      };
    };

    extras-gui = {
      nixos =
        { user, ... }:
        {
          environment.persistence."/nix/persist".users."${user}".directories = lib.mkAfter [
            ".config/legcord"
            ".config/onlyoffice"
            ".config/vlc"
            ".local/share/PrismLauncher"
            ".local/share/com.vixalien.sticky"
            ".local/share/onlyoffice"
            ".local/share/vlc"
          ];
        };

      homeManager =
        { pkgs, ... }:
        {
          programs.onlyoffice.enable = true;
          home.packages = with pkgs; [
            cool-retro-term
            bleachbit
            czkawka-full
            cpu-x
            chromium
            kopia-ui
            kid3-kde
            #clamtk
            #(inputs.thorium.thorium-avx .overrideAttrs (oldAttrs: { }))
            rclone-browser
            fclones-gui
            lan-mouse
            legcord
            mailspring
            media-downloader
            mtr-gui
            music-discord-rpc
            seafile-client
            media-downloader
            spotify-qt
            morphosis
            tenacity
            inkscape-with-extensions
            pinta
            rnote
            sticky-notes
            vlc

            #ayugram-desktop
            #(pkgs.callPackage ./custom/jdownloader.nix { })
            #(pkgs.callPackage ./custom/ytdl.nix { })
            #vlc-pause-click-plugin vlc-plugin-pipewire vlc-plugin vlc-plugins-all vlc-plugin-ytdl-git
            #https://github.com/Shabinder/SpotiFlyer
            #https://davidepucci.it/doc/spotitube/#installation
            #davinci-resolve
            #lightworks
            #lunacy
            #mission-center
            #https://github.com/trmckay/fzf-open
            #https://github.com/undergroundwires/privacy.sexy
            #natron
            #sonic-visualiser]
            # https://github.com/paulpacifico/shutter-encoder
            #https://github.com/tkmxqrdxddd/davinci-video-converter
            #https://tahoma2d.org/
          ];
        };
    };
  };
}

{ lib, ... }:
{
  den.aspects.gui.extras = {
    nixos =
      {
        isPersistent,
        isServer,
        user,
        ...
      }:
      lib.optionalAttrs (isPersistent && !isServer) {
        environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
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
      {
        isPersistent,
        isServer,
        pkgs,
        self',
        ...
      }:
      lib.optionalAttrs (isPersistent && !isServer) {
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
          jdownloader
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
          self'.packages.ytdl

          #ayugram-desktop
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
          #sonic-visualiser
          # https://github.com/paulpacifico/shutter-encoder
          #https://github.com/tkmxqrdxddd/davinci-video-converter
          #https://tahoma2d.org/
        ];
      };
  };
}

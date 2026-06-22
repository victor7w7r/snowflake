{ lib, ... }:
{
  flake-file.inputs.custom-packages.url = "github:Rishabh5321/custom-packages-flake";

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
        inputs',
        pkgs,
        self',
        ...
      }:
      lib.optionalAttrs (isPersistent && !isServer) {
        programs.onlyoffice.enable = true;
        home.packages =
          with pkgs;
          [
            #(inputs.thorium.thorium-avx .overrideAttrs (oldAttrs: { }))
            cool-retro-term
            bleachbit
            czkawka-full
            cpu-x
            chromium
            kopia-ui
            kid3-kde
            clamtk
            rclone-browser
            fclones-gui
            jdownloader
            lan-mouse
            legcord
            mailspring
            media-downloader
            mission-center
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
            #https://github.com/Shabinder/SpotiFlyer
            #https://davidepucci.it/doc/spotitube/#installation
            #davinci-resolve
            #lightworks
            #lunacy
            #https://github.com/trmckay/fzf-open
            #natron
            #https://github.com/debasish-patra-1987/linuxthemestore
            #sonic-visualiser
            # https://github.com/paulpacifico/shutter-encoder
            #vlc-pause-click-plugin vlc-plugin-pipewire vlc-plugin vlc-plugins-all vlc-plugin-ytdl-git
            #https://github.com/tkmxqrdxddd/davinci-video-converter
            #https://tahoma2d.org/
          ]
          ++ (lib.optionals isX86 [
            inputs'.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.thorium-sse3
          ]);
      };
  };
}

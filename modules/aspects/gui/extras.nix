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
            bleachbit
            chromium
            clamtk
            cool-retro-term
            cpu-x
            czkawka-full
            davinci-resolve
            fclones-gui
            inkscape-with-extensions
            jdownloader
            kopia-ui
            kid3-kde
            lan-mouse
            legcord
            lightworks
            lunacy
            mailspring
            media-downloader
            mission-center
            morphosis
            mtr-gui
            music-discord-rpc
            natron
            pinta
            rclone-browser
            rnote
            seafile-client
            sonic-visualiser
            spotify-qt
            sticky-notes
            tenacity
            vlc
            self'.packages.fzf-open
            self'.packages.ytdl
            self'.packages.shutter-encoder
            #https://github.com/tkmxqrdxddd/davinci-video-converter
            #https://tahoma2d.org/
            #vlc-pause-click-plugin vlc-plugin-pipewire vlc-plugin vlc-plugins-all vlc-plugin-ytdl-git
          ]
          ++ (lib.optionals isX86 [
            inputs'.custom-packages.packages.${pkgs.stdenv.hostPlatform.system}.thorium-sse3
          ]);
      };
  };
}

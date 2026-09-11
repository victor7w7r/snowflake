{
  flake-file.inputs.custom-packages.url = "github:Rishabh5321/custom-packages-flake";

  den.aspects.gui.extras =
    { user, ... }:
    {
      nixos =
        {
          isPersistent,
          isServer,
          lib,
          ...
        }:
        lib.optionalAttrs (isPersistent && !isServer) {
          environment.persistence."/nix/persist".users."${user.name}".directories = lib.mkAfter [
            ".config/legcord"
            ".config/onlyoffice"
            ".config/vlc"
            ".local/share/PrismLauncher"
            ".local/share/com.vixalien.sticky"
            ".local/share/jdownloader"
            ".local/share/onlyoffice"
            ".local/share/vlc"
          ];
        };

      provides.to-users.homeManager =
        {
          inputs',
          isPersistent,
          isPhone,
          isServer,
          isX86,
          lib,
          pkgs,
          self',
          ...
        }:
        lib.optionalAttrs (isPersistent && !isServer) {
          programs.onlyoffice.enable = isX86;
          home.packages =
            with pkgs;
            with self'.packages;
            [
              bleachbit
              clamtk
              cool-retro-term
              czkawka-full
              fclones-gui
              fzf-open
              media-downloader
              mission-center
              mtr-gui
              rnote
              ytdl
            ]
            ++ (lib.optionals (!isPhone) [
              inkscape-with-extensions
              jdownloader
              kid3-kde
              kopia-ui
              lan-mouse
              legcord
              linuxthemestore
              lunacy
              morphosis
              music-discord-rpc
              rclone-browser
              sonic-visualiser
              spotify-qt
              sticky-notes
              tahoma2d
              tenacity
              watchyourlan
              vlc
              #davinci-resolve
              #davinci-video-converter
              #natron
              #shutter-encoder
            ])
            ++ (lib.optionals isX86 [
              cpu-x
              lightworks
              inputs'.custom-packages.packages.thorium-sse3
              xpipe
            ]);
        };
    };
}

{ inputs, ... }: {
  flake-file.inputs.siyuan-nix.url = "github:mtul0729/siyuan-nix";

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
            ".config/chromium"
            ".config/deckcraft"
            ".config/effectcraft"
            ".config/gridcraft"
            ".config/legcord"
            ".config/photocraft"
            ".config/siyuan"
            ".config/SiYuan-Electron"
            ".config/vectorcraft"
            ".config/vlc"
            ".config/wordcraft"
            ".local/share/com.vixalien.sticky"
            ".local/share/filmcraft"
            ".local/share/jdownloader"
            ".local/share/pdfcraft"
            ".local/share/PrismLauncher"
            ".local/share/vlc"
          ];

          programs.appimage = {
            enable = true;
            binfmt = true;
          };
        };

      provides.to-users.homeManager =
        {
          isPersistent,
          isPhone,
          isServer,
          isX86,
          isMain,
          lib,
          pkgs,
          config,
          self',
          inputs',
          ...
        }:
        lib.optionalAttrs (isPersistent && !isServer) {
          dbus.packages = [ config.programs.chromium.package ];
          programs = {
            chromium.enable = true;

            artcraft = lib.optionalAttrs (!isPhone) {
              enable = true;
              apps = [
                "deckcraft"
                "effectcraft"
                "filmcraft"
                "gridcraft"
                "pdfcraft"
                "photocraft"
                "vectorcraft"
                "wordcraft"
              ];
            };
          };

          imports = [ inputs.artcraft.homeManagerModules.default ];

          home.packages =
            with pkgs;
            with self'.packages;
            [
              clamtk
              cool-retro-term
              czkawka-full
              fclones-gui
              fzf-open
              media-downloader
              mission-center
              mtr-gui
              rnote
              inputs'.siyuan-nix.packages.siyuan-client
              ytdl
            ]
            ++ (lib.optionals (!isPhone) [
              jdownloader
              kid3-kde
              #lan-mouse
              legcord
              linuxthemestore
              #morphosis
              rclone-browser
              sonic-visualiser
              sticky-notes
              tahoma2d
              tenacity
              watchyourlan
              vlc
              #davinci-resolve
              #davinci-video-converter
              #shutter-encoder
            ])
            ++ (lib.optionals isX86 [
              cpu-x
              xpipe
            ]);
        }
        // (lib.optionalAttrs isMain {
          xdg.configFile."autostart/siyuan.desktop".text = ''
            [Desktop Entry]
            Type=Application
            Name=Siyuan
            Exec=${inputs'.siyuan-nix.packages.siyuan-client}/bin/siyuan
            Terminal=false
          '';
        });
    };
}

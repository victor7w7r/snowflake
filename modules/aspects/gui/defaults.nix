{ den, lib, ... }:
{
  den.aspects.gui = {
    includes = with den.aspects.gui._; [
      disk-management
      fonts
      gtk
      kitty
      libinput
      xdg
      zed
    ];

    nixos =
      { pkgs, user, ... }:
      {
        services = {
          gvfs.enable = true;
          xserver.enable = true;
        };
        hardware.uinput.enable = true;
        environment = {
          persistence."/nix/persist".users."${user}".directories = lib.mkAfter [
            ".config/legcord"
            ".config/onlyoffice"
            ".config/vlc"
            ".local/share/PrismLauncher"
            ".local/share/com.vixalien.sticky"
            ".local/share/onlyoffice"
            ".local/share/vlc"
          ];
          systemPackages = with pkgs; [
            evemu
            keyd
            libinput
          ];
        };
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
}

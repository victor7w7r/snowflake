{ lib, hosts-attrs, ... }:
{
  den.aspects.gui.provides = lib.genAttrs hosts-attrs.softwaregui (_: {
    nixos =
      { pkgs, ... }:
      {
        services.xserver.enable = true;
        environment.systemPackages = with pkgs; [

        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        programs.onlyoffice.enable = true;
        home.packages = with pkgs; [
          cool-retro-term
          kopia-ui
          kid3-kde
          media-downloader
          spotify-qt
          vlc
          morphosis
          tenacity
          inkscape-with-extensions
          pinta
          rnote
          sticky-notes

          #(pkgs.callPackage ./custom/ytdl.nix { })
          #vlc-pause-click-plugin vlc-plugin-pipewire vlc-plugin vlc-plugins-all vlc-plugin-ytdl-git
          #https://github.com/Shabinder/SpotiFlyer
          #https://davidepucci.it/doc/spotitube/#installation
          #davinci-resolve
          #lightworks
          #lunacy
          #natron
          #sonic-visualiser]
          # https://github.com/paulpacifico/shutter-encoder
          #https://github.com/tkmxqrdxddd/davinci-video-converter
          #https://tahoma2d.org/
        ];
      };
  });
}

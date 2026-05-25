{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      catimg
      feh
      imgcat
      jfbview
      lsix
      mediainfo
      timg
      tuicam
    ]
    ++ [
      asciinema-agg
      dipc
      jp2a
      slides
      ttygif
      vhs

      #spotify-adblock-git
      #spotify-adkiller-dns-block-git
      #https://github.com/carlocastoldi/blockify
      #https://github.com/trizen/clyrics
      #https://github.com/SathyaBhat/spotify-dl
      #https://github.com/foresterre/imagineer
    ];
}

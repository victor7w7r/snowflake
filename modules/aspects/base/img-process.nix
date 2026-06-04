{ lib, ... }:
{
  den.aspects.base.img-process.nixos =
    { isVisual, pkgs, ... }:
    lib.optional isVisual {
      environment.systemPackages = with pkgs; [
        catimg
        feh
        imgcat
        jfbview
        lsix
        mediainfo
        timg
        tuicam
        asciinema-agg
        dipc
        jp2a
        slides
        ttygif
        vhs
      ];
    };
}

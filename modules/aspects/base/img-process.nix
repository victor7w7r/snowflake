{ lib, ... }:
{
  den.aspects.base.img-process = {
    os =
      {
        isVisual,
        isMainMac,
        pkgs,
        ...
      }:
      {
        environment.systemPackages =
          with pkgs;
          lib.optionals (isVisual || isMainMac) [
            asciinema-agg
            catimg
            dipc
            feh
            imgcat
            jp2a
            lsix
            mediainfo
            slides
            timg
            ttygif
            vhs
          ];
      };
    nixos =
      { isVisual, pkgs, ... }:
      {
        environment.systemPackages =
          with pkgs;
          lib.optionals isVisual [
            jfbview
            tuicam
          ];
      };
  };
}

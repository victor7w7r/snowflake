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
      lib.optional (isVisual || isMainMac) {
        environment.systemPackages = with pkgs; [
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
      lib.optional isVisual {
        environment.systemPackages = with pkgs; [
          jfbview
          tuicam
        ];
      };
  };
}

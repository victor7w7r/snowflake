{ ... }:
{
  den.aspects.img-processing.nixos =
    { pkgs, ... }:
    {
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

{ pkgs, fetchurl }:
pkgs.appimageTools.wrapType2 {
  pname = "hyprmixer";
  version = "1.0.1";

  src = fetchurl {
    url = "https://github.com/Torelli/hyprmixer/releases/download/1.0.1/hyprmixer.AppImage";
    sha256 = "sha256-J6wVcyQZGXPBISUMHyuAAAj7/2Js/9MJYFobfBwvaWc=";
  };

  extraPkgs =
    pkgs: with pkgs; [
      rofi
    ];
}

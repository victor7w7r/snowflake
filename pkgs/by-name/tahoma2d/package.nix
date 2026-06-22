{ pkgs, fetchurl }:
pkgs.appimageTools.wrapType2 {
  pname = "shutter-encoder";
  version = "18.0";

  src = fetchurl {
    url = "https://github.com/tahoma2d/tahoma2d/releases/download/v1.6.1/Tahoma2D-linux-clang.tar.gz";
    sha256 = "sha256-mUXSY9186j9zeAAAAzfEJK2Phw+r6H7vjIkcZQGqph4=";
  };

  extraPkgs =
    pkgs: with pkgs; [
      gtk3
      glib
    ];
}

{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "kf6-servicemenus-rootactions";
  version = "1.0.0";

  src = pkgs.fetchFromGitLab {
    owner = "stefanwimmer128";
    repo = "kf6-servicemenus-rootactions";
    rev = "HEAD";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    kdePackages.dolphin
    kdePackages.kdialog
    imagemagick
    perl
    polkit
  ];

  configurePhase = "./configure --prefix=$out";
  buildPhase = "make";
  installPhase = "make install";
}

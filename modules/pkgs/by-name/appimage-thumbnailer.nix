{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "appimage-thumbnailer";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "realmazharhussain";
    repo = "appimage-thumbnailer";
    rev = "HEAD";
    sha256 = "sha256-Y7s9qdJIJbUqEP0/6qlTPOtE3efRqL1bx66MJIPgRN4=";
  };

  buildInputs = with pkgs; [
    bash
    imagemagick
  ];

  installPhase = ''
    mkdir -p $out/bin $out/profiles
    export PREFIX=$out
    export DESTDIR=""
    chmod +x install.sh
    ./install.sh
  '';
}

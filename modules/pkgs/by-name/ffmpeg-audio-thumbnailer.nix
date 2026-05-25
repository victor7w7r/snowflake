{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "ffmpeg-audio-thumbnailer";
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "saltedcoffii";
    repo = "ffmpeg-audio-thumbnailer";
    rev = "HEAD";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [ kdePackages.ffmpeg ];

  buildPhase = "make";
  installPhase = "export PREFIX=$out; make install";
}

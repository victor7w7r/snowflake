{
  lib,
  pkgs,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "jar-thumbnailer";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "realmazharhussain";
    repo = "jar-thumbnailer";
    rev = "HEAD";
    sha256 = lib.fakeSha256;
  };

  buildInputs = with pkgs; [
    bash
    unzip
    coreutils
    gnused
  ];

  installPhase = ''
    export PREFIX=$out
    export DESTDIR=""
    chmod +x install.sh
    ./install.sh
  '';
}

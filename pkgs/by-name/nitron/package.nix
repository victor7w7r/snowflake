{ pkgs, stdenv }:
stdenv.mkDerivation rec {
  pname = "nitronx";
  version = "1.2";

  src = pkgs.fetchFromGitHub {
    owner = "UsiFX";
    repo = "OpenNitroN";
    rev = "${version}";
    sha256 = "sha256-vF1HKJ5yL5ptBFRbhlKGVgtRDpP1pv9ruUWPu46O00M=";
  };

  installPhase = ''
    mkdir -p $out/usr/bin
    mkdir -p $out/usr/include

    install -m 755 nitrond $out/usr/bin/nitrond
    install -m 644 nitronapi.sh $out/usr/include/nitronapi.sh
  '';
}

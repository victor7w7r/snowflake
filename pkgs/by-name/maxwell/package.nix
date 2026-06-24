{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "maxwell";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "wilversings";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-rDjfiZ7PEioh8xS2jWNRDIVhOWNiIm2ft6tNX5ZkeT4=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/maxwell
    mv * $out/share/plasma/plasmoids/maxwell/
  '';
})

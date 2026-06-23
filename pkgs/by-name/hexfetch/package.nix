{ pkgs, stdenv }:

stdenv.mkDerivation (attrs: {
  pname = "hexfetch";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "hexisXz";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  buildPhase = ''
    cd src
    gcc hexfetch.c -o hexfetch
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hexfetch $out/bin/
  '';
})

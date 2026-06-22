{ pkgs, stdenv }:

stdenv.mkDerivation (attrs: {
  pname = "fortunes-es";
  version = "1.36";

  src = pkgs.fetchurl {
    url = "http://ftp.es.debian.org/debian/pool/main/f/fortunes-es/fortunes-es_1.36+nmu1.tar.xz";
    sha256 = "tu-hash-aqui";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  # dontBuild = true;

  installPhase = ''
    install -d "$out/share/fortune"
    make COOKIEDIR="$out/share/fortune/" STRFILE="strfile" install-utf8

    cd "$out/share/fortune"
    rm -f *.u8 off/*.u8 2>/dev/null || true

    shopt -s nullglob
    for f in *.fortunes* off/*.fortunes*; do
      mv "$f" "''${f/.fortunes}"
    done
    shopt -u nullglob
  '';
})

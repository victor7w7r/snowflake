{ fetchurl, stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  pname = "open";
  version = "0.0.3";

  src = fetchurl {
    url = "https://github.com/witt-bit/pc-guide/releases/download/v${version}/open.sh";
    sha256 = "d9d0ae0225817945f4c8cf8a37741ce884226c6b8f66066a557f122c4d3c2305";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/open
    chmod +x $out/bin/open
  '';
}

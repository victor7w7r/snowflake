{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-anarchism";
  version = "1.9.0";

  src = pkgs.fetchurl {
    url = "http://deb.debian.org/debian/pool/main/b/blag-fortune/blag-fortune_${attrs.version}.orig.tar.gz";
    sha256 = "sha256-LTUYLpSWvFgQO9ttJjbhjwTit4u/xupR0EkkhyhZgpo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- anarchism anarchism.dat "$out/share/fortune"
  '';
})

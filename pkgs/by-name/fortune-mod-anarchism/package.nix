{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-anarchism";
  version = "1.9.0";

  src = pkgs.fetchurl {
    url = "http://deb.debian.org/debian/pool/main/b/blag-fortune/blag-fortune_${attrs.version}.orig.tar.gz";
    sha256 = "2d35182e9496bc58103bdb6d2636eAAAA4e2b78bbfc6ea51d04924872859829a";
  };

  #buildInputs = [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- anarchism anarchism.dat "$out/share/fortune"
  '';
})

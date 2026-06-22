{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-calvin";
  version = "0.3";

  src = pkgs.fetchurl {
    url = "http://www.netmeister.org/misc.html";
    sha256 = "sha256-NU0pMmRcbMuZ91GFRXJ/Y7LQNAAAJnCMPhL1MB5eW9E=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src calvin
    strfile calvin
    install -dm755 -- "$out/share/fortune"
    install -m644 -- calvin calvin.dat "$out/share/fortune"
  '';
})

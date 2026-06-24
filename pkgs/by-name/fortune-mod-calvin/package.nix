{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-calvin";
  version = "0.3";

  src = pkgs.fetchurl {
    url = "http://www.netmeister.org/misc.html";
    sha256 = "sha256-vRbQYpJtRmA5MeLubxQ8ulNvvKXviGg46Wwhjm3Zh70=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src calvin
    strfile calvin
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- calvin calvin.dat "$out/share/games/fortunes"
  '';
})

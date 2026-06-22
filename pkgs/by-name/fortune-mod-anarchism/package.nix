{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-dhammapada";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/bodhi.zazen/display-dhammapada/-/archive/main/display-dhammapada-main.tar.gz";
    sha256 = "sha256-LTUYLpSWvFgAA9ttJjbhjwTit4u/xupR0EkkhyhZgpo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -d $out/share/fortune"

    install -m 644 "$src/dhammapada" "$out/share/fortune/dhammapada"
    install -m 644 "$src/dhammapada.m" "$out/share/fortune/dhammapada.m"
    install -m 644 "$src/dhammapada.de" "$out/share/fortune/dhammapada.de"
    install -m 644 "$src/dhammapada.pl" "$out/share/fortune/dhammapada.pl"

    strfile "$out/share/fortune/dhammapada"
    strfile "$out/share/fortune/dhammapada.m"
    strfile "$out/share/fortune/dhammapada.de"
    strfile "$out/share/fortune/dhammapada.pl"
  '';
})

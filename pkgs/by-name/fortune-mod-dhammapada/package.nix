{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-dhammapada";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/bodhi.zazen/display-dhammapada/-/archive/main/display-dhammapada-main.tar.gz";
    sha256 = "sha256-NXpovMrJXpAgvTxYYFzlQ0qMyloaBQW3MGIob/0pRiU=";
  };

  dontBuild = true;
  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -d $out/share/fortune
    mkdir -p dhammapada-extract

    tar -xJf fortune-dhammapada-1.0.tar.xz -C dhammapada-extract

    install -m 644 dhammapada-extract/fortune-dhammapada-1.0/usr/share/games/fortune/dhammapada $out/share/fortune/dhammapada
    install -m 644 dhammapada-extract/fortune-dhammapada-1.0/usr/share/games/fortune/dhammapada.m $out/share/fortune/dhammapada.m
    install -m 644 dhammapada-extract/fortune-dhammapada-1.0/usr/share/games/fortune/dhammapada.de $out/share/fortune/dhammapada.de
    install -m 644 dhammapada-extract/fortune-dhammapada-1.0/usr/share/games/fortune/dhammapada.pl $out/share/fortune/dhammapada.pl

    strfile $out/share/fortune/dhammapada
    strfile $out/share/fortune/dhammapada.m
    strfile $out/share/fortune/dhammapada.de
    strfile $out/share/fortune/dhammapada.pl
  '';
})

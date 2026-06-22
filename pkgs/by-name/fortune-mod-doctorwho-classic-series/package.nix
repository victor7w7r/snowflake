{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-doctorwho-classic-series";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/doctorwho-classic-series?h=fortune-mod-doctorwho-classic-series";
    sha256 = "sha256-ennEKmjsgUAUDAM4L5/JAFbTCQwPaCr0WOSR2F81HPA=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src doctorwho-classic-series
    strfile doctorwho-classic-series
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- doctorwho-classic-series doctorwho-classic-series.dat "$out/share/games/fortunes"
  '';
})

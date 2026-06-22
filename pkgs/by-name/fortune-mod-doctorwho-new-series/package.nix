{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-doctorwho-new-series";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/doctorwho-new-series?h=fortune-mod-doctorwho-new-series";
    sha256 = "sha256-ZFmLCNqb6nDfZKFUdKD5hOHiIyA6ZemqIynh/VeRu5M=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src doctorwho-new-series
    strfile doctorwho-new-series
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- doctorwho-new-series doctorwho-new-series.dat "$out/share/games/fortunes"
  '';
})

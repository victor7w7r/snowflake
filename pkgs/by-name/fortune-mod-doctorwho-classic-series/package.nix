{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-doctorwho-classic-series";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://tvtropes.org/pmwiki/pmwiki.php/Quotes/DoctorWhoClassicSeriesDoctors";
    sha256 = "sha256-NU0pMmRcbMuZ91GFRXJ/Y7LQNkN7JnCMAAL1MB5eW9E=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src doctorwho-classic-series
    strfile doctorwho-classic-series
    install -dm755 -- "$out/share/fortune"
    install -m644 -- doctorwho-classic-series doctorwho-classic-series.dat "$out/share/fortune"
  '';
})

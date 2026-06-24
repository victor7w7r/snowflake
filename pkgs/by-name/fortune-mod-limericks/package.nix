{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-limericks";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://billy.wolfe.casa/fortunes/limericks";
    sha256 = "sha256-NU0pMmRcbMuZ91GFRXJ/Y7LQNkN7JnCMAAL1MB5eW9E=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src limericks
    strfile limericks
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- limericks limericks.dat "$out/share/games/fortunes"
  '';
})

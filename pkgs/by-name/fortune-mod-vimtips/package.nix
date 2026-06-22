{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-vimtips";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/hobbestigrou/vimtips-fortune/master/fortunes/vimtips";
    sha256 = "sha256-NU0pMmRcbMuZ91GFRXJ/Y7LQNkN7JnCMPhL1MB5eW9E=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src vimtips
    strfile vimtips
    install -dm755 -- "$out/share/fortune"
    install -m644 -- vimtips vimtips.dat "$out/share/fortune"
  '';
})

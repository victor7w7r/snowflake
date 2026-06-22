{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-archlinux";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/archlinux?h=fortune-mod-archlinux";
    sha256 = "sha256-NU0pMmRcbMuZ91GFRXJ/Y7LQNkN7JnCMPhL1AAAeW9E=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src archlinux
    strfile archlinux
    install -dm755 -- "$out/share/fortune"
    install -m644 -- archlinux archlinux.dat "$out/share/fortune"
  '';
})

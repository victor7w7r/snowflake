{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-darkknight";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/darkknight?h=fortune-mod-darkknight";
    sha256 = "sha256-RBFckO8zaY03Yd0BgPnTcL2S0uPsY17TzncWV9rnur4=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src darkknight
    strfile darkknight
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- darkknight darkknight.dat "$out/share/games/fortunes"
  '';
})

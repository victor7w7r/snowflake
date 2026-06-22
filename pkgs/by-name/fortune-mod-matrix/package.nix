{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-matrix";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/fortunes.txt?h=fortune-mod-matrix";
    sha256 = "sha256-47DEQpj8HBSa+/TImW+5JCeuQAAAm5NMpJWZG3hSuFU=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src matrix
    strfile matrix
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- matrix matrix.dat "$out/share/games/fortunes"
  '';
})

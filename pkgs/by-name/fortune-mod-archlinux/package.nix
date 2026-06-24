{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-archlinux";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/archlinux?h=fortune-mod-archlinux";
    sha256 = "sha256-NhSJW7QPoejmhf3nqsXmF/CIEAmNAMWD90/58m44n3Y=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src archlinux
    strfile archlinux
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- archlinux archlinux.dat "$out/share/games/fortunes"
  '';
})

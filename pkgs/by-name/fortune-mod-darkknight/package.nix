{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-darkknight";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/darkknight?h=fortune-mod-darkknight";
    sha256 = "sha256-ZFmLCNqb6nDfZKFUdKD5hOHiIyAAAemqIynh/VeRu5M=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src darkknight
    strfile darkknight
    install -dm755 -- "$out/share/fortune"
    install -m644 -- darkknight darkknight.dat "$out/share/fortune"
  '';
})

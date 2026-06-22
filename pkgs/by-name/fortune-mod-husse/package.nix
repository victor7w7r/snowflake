{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-husse";
  version = "latest";

  src1 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-funny?h=fortune-mod-husse";
    sha256 = "sha256-bCMLlESSJeCq/AAA//qO4ZeSK0DqErfAApLl3kLK7hM=";
  };

  src2 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-helping?h=fortune-mod-husse";
    sha256 = "sha256-bCMLlESSJeCq/AAA//qO4ZeSK0DqErfAApLl3kLK7hM=";
  };

  src3 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-moderating?h=fortune-mod-husse";
    sha256 = "sha256-bCMLlESSJeCq/AAA//qO4ZeSK0DqErfAApLl3kLK7hM=";
  };

  src4 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/husse-self?h=fortune-mod-husse";
    sha256 = "sha256-bCMLlESSJeCq/AAA//qO4ZeSK0DqErfAApLl3kLK7hM=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src1 husse-funny
    cp $src2 husse-helping
    cp $src3 moderating
    cp $src4 husse-self

    strfile husse-funny
    strfile husse-helping
    strfile moderating
    strfile husse-self

    install -dm755 -- "$out/share/fortune"
    install -m644 -- husse-funny husse-funny.dat "$out/share/fortune"
    install -m644 -- husse-helping husse-helping.dat "$out/share/fortune"
    install -m644 -- moderating moderating.dat "$out/share/fortune"
    install -m644 -- husse-self husse-self.dat "$out/share/fortune"
  '';
})

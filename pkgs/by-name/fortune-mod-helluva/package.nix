{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-helluva";
  version = "latest";

  src1 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/beelzebub?h=fortune-mod-helluva";
    sha256 = "sha256-bCMLlESSJeCq/H+1//qO4ZeSK0DqErf19pLl3kLK7hM=";
  };

  src2 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/blitz?h=fortune-mod-helluva";
    sha256 = "sha256-hgKGw5s2FynZAkOFmAirZtxvhuXXe/ElMyG/uAFO71c=";
  };

  src3 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/loona?h=fortune-mod-helluva";
    sha256 = "sha256-3vxvaLDpxzBiDe2z2T1KzCOTHa65s5cj0kfGX+uRK5k=";
  };

  src4 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/millie?h=fortune-mod-helluva";
    sha256 = "sha256-wQjbIFqDouxcBtDnXdCE9xp7YItTtHDbtl1u+jNxheM=";
  };

  src5 = pkgs.fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/moxxie?h=fortune-mod-helluva";
    sha256 = "sha256-HDPKzLEQkZOCqnkJvQdQAqDYA3xEePmBa/D3xLQUEsQ=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src1 beelzebub
    cp $src2 blitz
    cp $src3 loona
    cp $src4 millie
    cp $src5 moxxie

    strfile beelzebub
    strfile blitz
    strfile loona
    strfile millie
    strfile moxxie

    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- beelzebub beelzebub.dat "$out/share/games/fortunes"
    install -m644 -- blitz blitz.dat "$out/share/games/fortunes"
    install -m644 -- loona loona.dat "$out/share/games/fortunes"
    install -m644 -- millie millie.dat "$out/share/games/fortunes"
    install -m644 -- moxxie moxxie.dat "$out/share/games/fortunes"
  '';
})

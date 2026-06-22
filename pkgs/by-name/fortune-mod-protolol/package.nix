{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-protolol";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "virtualtam";
    repo = "fortune-protolol";
    rev = attrs.version;
    sha256 = "sha256-53IctpfVaeV/cJQE+hlY16AfCX1d7L6vVnD+GDhQVFQ=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- protolol protolol.dat "$out/share/games/fortunes"
  '';
})

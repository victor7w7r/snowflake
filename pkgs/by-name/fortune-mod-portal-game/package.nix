{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-portal-game";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "outadoc";
    repo = "portal-fortunes";
    rev = attrs.version;
    sha256 = "sha256-uYyodVXJFA9ZKWDDlLJoMYTuAK2qHBgnu6nRxWJKrdU=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/games/fortunes"
    mv fortunes/announcer .
    mv fortunes/announcer.dat .
    install -m644 -- announcer announcer.dat "$out/share/games/fortunes"
  '';
})

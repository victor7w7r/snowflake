{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-canada-nctr";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "mikebirdgeneau";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-C7hDtRRWgMwkkZxjIPumcLAHyYMmFZ5D4urBgPTZmKA=";
  };

  dontBuild = true;
  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile nctr
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- nctr nctr.dat "$out/share/games/fortunes"
  '';
})

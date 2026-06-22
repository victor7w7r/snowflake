{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-leftism";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "anakojm";
    repo = "leftist-quote";
    rev = attrs.version;
    sha256 = "sha256-C7hDtAAAgMwkkZxjIPumcLAHyYMmFZ5D4urBgPTZmKA=";
  };

  dontBuild = true;
  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile leftist-quotes
    install -dm755 -- "$out/share/fortune"
    install -m644 -- leftist-quotes leftist-quotes.dat "$out/share/fortune"
  '';
})

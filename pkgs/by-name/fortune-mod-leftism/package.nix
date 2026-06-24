{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-leftism";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "anakojm";
    repo = "leftist-quote";
    rev = attrs.version;
    sha256 = "sha256-tV1EidE3/iNu7AKa9MIHppGLG2cYOELfkUvCGmZnPoE=";
  };

  dontBuild = true;
  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    strfile leftist-quotes
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- leftist-quotes leftist-quotes.dat "$out/share/games/fortunes"
  '';
})

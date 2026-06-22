{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "conway-screensaver";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "cdkw2";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wqXCmm2CAp+xAAAMsK17lW9PdFqVPBh+N156qivDdC0=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
  ];

  makeFlags = [ "PREFIX=$(out)" ];
})

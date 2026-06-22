{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "neo";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "st3w";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wqXCmm2CAp+xgNWMsK17lW9PdFqVPBh+N156qivDdC0=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
  ];

  preConfigure = "./autogen.sh";
  makeFlags = [ "PREFIX=$(out)" ];
})

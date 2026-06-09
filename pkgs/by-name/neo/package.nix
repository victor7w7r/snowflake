{
  autoconf,
  automake,
  ncurses,
  fetchFromGitHub,
  pkg-config,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "neo";
  version = "main";

  src = fetchFromGitHub {
    owner = "st3w";
    repo = pname;
    rev = version;
    sha256 = "sha256-wqXCmm2CAp+xgNWMsK17lW9PdFqVPBh+N156qivDdC0=";
  };

  buildInputs = [ ncurses ];

  nativeBuildInputs = [
    pkg-config
    autoconf
    automake
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  makeFlags = [ "PREFIX=$(out)" ];
}

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "bartobri";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "no-more-secrets";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wqXCmm2CAp+xgNWMsK17lAAAdFqVPBh+N156qivDdC0=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
  ];

  buildFlags = [
    "nms-ncurses"
    "sneakers-ncurses"
  ];
  makeFlags = [ "PREFIX=$(out)" ];
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "ncmatrix";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "tree-s";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wqXCmm2CAp+xgNWMsAAAlW9PdFqVPBh+N156qivDdC0=";
  };

  nativeBuildInputs = [
    pkgs.autoreconfHook
    pkgs.automake
    pkgs.autoconf
  ];
})

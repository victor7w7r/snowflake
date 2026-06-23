{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "frenzch";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "FrenzyExists";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KZlrh+GWkAAQ9RXBLO8hK+MeUrrT2ode9VO+ZohpOJA=";
  };

  prePatch = "patchShebangs ./";

  makeFlags = [
    "PREFIX=$(out)"
  ];
})

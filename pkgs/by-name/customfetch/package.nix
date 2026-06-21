{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "customfetch";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "Toni500github";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KZlrh+GWknAQ9RXBLO8hK+MeUrrT2ode9VO+ZohpOJA=";
  };

  nativeBuildInputs = with pkgs; [
    gettext
    git
    pkg-config
  ];

  prePatch = "patchShebangs scripts/";

  makeFlags = [
    "DEBUG=0"
    "GUI_APP=0"
    "PREFIX=$(out)"
  ];
})

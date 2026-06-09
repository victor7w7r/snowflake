{
  stdenv,
  fetchFromGitHub,
  gettext,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "customfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "Toni500github";
    repo = pname;
    rev = version;
    sha256 = "sha256-KZlrh+GWknAQ9RXBLO8hK+MeUrrT2ode9VO+ZohpOJA=";
  };

  nativeBuildInputs = [
    pkg-config
    gettext
  ];

  prePatch = "patchShebangs scripts/";

  makeFlags = [
    "DEBUG=0"
    "GUI_APP=0"
    "PREFIX=$(out)"
  ];
}

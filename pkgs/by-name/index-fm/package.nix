{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation (attrs: {
  pname = "index-fm";
  version = "4.0.2";

  src = pkgs.fetchFromGitHub {
    owner = "KDE";
    repo = "index-fm";
    tag = "v${attrs.version}";
    hash = "sha256-5h/HNdXl3O8QBfhoJl8oTJbOxn0Jv0yOO1rlTVIuWsQ=";
  };

  nativeBuildInputs = with pkgs; [ cmake ];

  buildInputs = with pkgs.kdePackages; [
    extra-cmake-modules
    #maui-core
    qtdeclarative
    qtsvg
    kdecoration
    qtbase
  ];
})

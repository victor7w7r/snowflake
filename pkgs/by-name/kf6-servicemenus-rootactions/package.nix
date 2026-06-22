{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "kf6-servicemenus-rootactions";
  version = "1.2.0";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/stefanwimmer128/kf6-servicemenus-rootactions/-/releases/v${attrs.version}/downloads/kf6-servicemenus-rootactions-v${attrs.version}.tar.xz";
    sha256 = "sha256-zhdIcjhc+axBO+sEYQ7rL1Hd2tMYCyCFKp0JqpMKRq8=";
  };

  nativeBuildInputs = with pkgs; [ cmake ];

  buildInputs = with pkgs; [
    kdePackages.dolphin
    kdePackages.kdialog
    imagemagick
    perl
    polkit
  ];

  dontWrapQtApps = true;

  configurePhase = "./configure --prefix=$out";
  buildPhase = "make";
  installPhase = "make install";
})

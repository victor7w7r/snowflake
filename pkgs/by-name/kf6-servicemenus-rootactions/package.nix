{
  kdePackages,
  fetchurl,
  pkg-config,
  imagemagick,
  perl,
  cmake,
  polkit,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "kf6-servicemenus-rootactions";
  version = "1.2.0";

  src = fetchurl {
    url = "https://gitlab.com/stefanwimmer128/kf6-servicemenus-rootactions/-/releases/v${version}/downloads/kf6-servicemenus-rootactions-v${version}.tar.xz";
    sha256 = "sha256-zhdIcjhc+axBO+sEYQ7rL1Hd2tMYCyCFKp0JqpMKRq8=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
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
}

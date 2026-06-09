{
  fetchFromGitHub,
  pkg-config,
  kdePackages,
  libzip,
  cmake,
  stdenv,
  shared-mime-info,
}:
stdenv.mkDerivation rec {
  pname = "kde-thumbnailer-apk";
  version = "main";

  src = fetchFromGitHub {
    owner = "z3ntu";
    repo = pname;
    rev = version;
    sha256 = "sha256-ANh9K6NLN261ByAays4Oh2CC7vnf/qLoLf9VlEENLv4=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    kdePackages.extra-cmake-modules
    shared-mime-info
  ];

  buildInputs = [
    kdePackages.kio
    libzip
  ];

  dontWrapQtApps = true;

  configurePhase = "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_INSTALL_LIBDIR=lib";
  buildPhase = "make -C build";
  installPhase = "make -C build install";
}

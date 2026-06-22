{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "kde-thumbnailer-apk";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "z3ntu";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-ANh9K6NLN261ByAays4Oh2CC7vnf/qLoLf9VlEENLv4=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    kdePackages.extra-cmake-modules
    shared-mime-info
  ];

  buildInputs = with pkgs; [
    kdePackages.kio
    libzip
  ];

  dontWrapQtApps = true;

  configurePhase = "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_INSTALL_LIBDIR=lib";
  buildPhase = "make -C build";
  installPhase = "make -C build install";
})

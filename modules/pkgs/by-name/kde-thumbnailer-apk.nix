{
  lib,
  pkgs,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "kde-thumbnailer-apk";
  version = "1.0.0";

  src = pkgs.fetchFromGitLab {
    owner = "z3ntu";
    repo = "kde-thumbnailer-apk";
    rev = "HEAD";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    kdePackages.kio
    libzip
  ];

  configurePhase = "cmake -B build -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_INSTALL_LIBDIR=lib";
  buildPhase = "make -C build";
  installPhase = "make -C build install";
}

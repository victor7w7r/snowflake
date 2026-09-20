{ pkgs, superlab-kernel }:
let
  kdev = "${superlab-kernel.dev}/lib/modules/${superlab-kernel.modDirVersion}/build";
in
superlab-kernel.stdenv.mkDerivation {
  pname = "rtl8192eu";
  version = "${superlab-kernel.modDirVersion}-4.4.1.20250504";

  src = pkgs.fetchFromGitHub {
    owner = "Mange";
    repo = "rtl8192eu-linux-driver";
    rev = "27aa922c298f2be240eec6c2e8636fe865ece195";
    sha256 = "sha256-1Kz/GgsHsEgrp+1x2rLpJpo98Ur16aWf9CV0gcYmp0Q=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];

  nativeBuildInputs =
    with pkgs;
    superlab-kernel.moduleBuildDependencies
    ++ [
      bc
      clang
      llvm
      lld
    ];

  makeFlags = [
    "CC=clang"
    "HOSTCC=clang"
    "LD=ld.lld"
    "HOSTLD=ld.lld"
    "ARCH=arm64"
    "KERNELRELEASE=${superlab-kernel.modDirVersion}"
  ];

  enableParallelBuilding = true;

  buildPhase = "make -C ${kdev} M=$(pwd) $makeFlags modules";

  installPhase = ''
    mkdir -p $out/lib/modules/${superlab-kernel.modDirVersion}/extra
    find . -name '*.ko' -exec cp {} $out/lib/modules/${superlab-kernel.modDirVersion}/extra/ \;
    find $out -type f -name '*.ko' -exec xz -f {} \;
  '';
}

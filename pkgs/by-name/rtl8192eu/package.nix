{ pkgs, superlab-kernel }:
let
  stdenvClang = pkgs.overrideCC pkgs.stdenv pkgs.llvmPackages_20.clang;
  modDestDir = "$out/lib/modules/${superlab-kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8192eu";
in
stdenvClang.mkDerivation {
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
      clang_20
      llvm_20
      lld_20
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
    make -C ${kdev} M=$(pwd) $makeFlags INSTALL_MOD_PATH=$out modules_install
    find $out -type f -name '*.ko' -exec xz -f {} \;
  '';
}

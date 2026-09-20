{
  pkgs,
  superlab-kernel,
  superlab-version,
}:
let
  modDestDir = "$out/lib/modules/${superlab-kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8192eu";
  stdenvClang = pkgs.overrideCC pkgs.stdenv pkgs.llvmPackages_20.clang;
in
stdenvClang.mkDerivation {
  pname = "rtl8192eu";
  version = "${superlab-version}-4.4.1.20250504";

  src = pkgs.fetchFromGitHub {
    owner = "Mange";
    repo = "rtl8192eu-linux-driver";
    rev = "27aa922c298f2be240eec6c2e8636fe865ece195";
    sha256 = "sha256-1Kz/GgsHsEgrp+1x2rLpJpo98Ur16aWf9CV0gcYmp0Q=";
  };

  hardeningDisable = [ "pic" ];

  nativeBuildInputs =
    with pkgs;
    kernel.moduleBuildDependencies
    ++ [ pkgs.bc ]
    ++ [
      clang_20
      llvm_20
      lld_20
    ];

  makeFlags = pkgs.kernelModuleMakeFlags ++ [
    "KSRC=${superlab-kernel.dev}/lib/modules/${superlab-kernel.modDirVersion}/build"
  ];

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p ${modDestDir}
    find . -name '*.ko' -exec cp --parents {} ${modDestDir} \;
    find ${modDestDir} -name '*.ko' -exec xz -f {} \;
  '';
}

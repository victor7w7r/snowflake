{
  pkgs,
  superlab-kernel,
  superlab-version,
}:
let
  kernelVersion = superlab-kernel.modDirVersion or superlab-version;
  modDestDir = "$out/lib/modules/${kernelVersion}/kernel/drivers/net/wireless/realtek/rtl8192eu";
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
    superlab-kernel.moduleBuildDependencies
    ++ (with pkgs; [
      bc
      clang_20
      llvm_20
      lld_20
    ]);

  makeFlags = [
    "CC=clang"
    "HOSTCC=clang"
    "LD=ld.lld"
    "HOSTLD=ld.lld"
    "ARCH=x86_64"
    "KERNELRELEASE=${kernelVersion}"
    "KDIR=${superlab-kernel.dev}/lib/modules/${kernelVersion}/build"
    "KSRC=${superlab-kernel.dev}/lib/modules/${kernelVersion}/build"
    "M=$(PWD)"
    "INSTALL_MOD_PATH=$(out)"
  ];

  enableParallelBuilding = true;

  buildPhase = "make -C ${superlab-kernel.dev}/lib/modules/${kernelVersion}/build M=$(pwd) modules";

  installPhase = ''
    mkdir -p ${modDestDir}
    find . -name '*.ko' -exec cp --parents {} ${modDestDir} \;
    find ${modDestDir} -name '*.ko' -exec xz -f {} \;
  '';
}

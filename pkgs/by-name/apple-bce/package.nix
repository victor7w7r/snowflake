{
  overrideCC,
  stdenv,
  llvmPackages_20,
  clang_20,
  llvm_20,
  lld_20,
  fetchFromGitHub,
  main-kernel,
}:
(overrideCC stdenv llvmPackages_20.clang).mkDerivation rec {
  name = "apple-bce";
  gitCommit = "5dd96d6ca0dd88d4a500639ed3923e258a81eb3f";
  version = "${gitCommit}";
  LLVM = "1";

  src = fetchFromGitHub {
    owner = "deqrocks";
    repo = "apple-bce";
    rev = gitCommit;
    sha256 = "sha256-GHc2EujgUzXttODVPmZUmBgetnBWJSaWPKVMNTdf89w=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];

  nativeBuildInputs = main-kernel.moduleBuildDependencies ++ [
    clang_20
    llvm_20
    lld_20
  ];

  makeFlags = [
    "CC=clang"
    "HOSTCC=clang"
    "LD=ld.lld"
    "HOSTLD=ld.lld"
    "ARCH=x86_64"
    "KERNELRELEASE=${main-kernel.modDirVersion}"
    "KDIR=${main-kernel.dev}/lib/modules/${main-kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];
}

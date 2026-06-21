{
  main-kernel,
  pkgs,
  llvmPackages,
  overrideCC,
  stdenv,
}:
(overrideCC stdenv llvmPackages.clang).mkDerivation (attrs: {
  name = "apple-bce";
  gitCommit = "5dd96d6ca0dd88d4a500639ed3923e258a81eb3f";
  version = "latest";
  LLVM = "1";

  src = pkgs.fetchFromGitHub {
    owner = "deqrocks";
    repo = "apple-bce";
    rev = attrs.gitCommit;
    sha256 = "sha256-GHc2EujgUzXttODVPmZUmBgetnBWJSaWPKVMNTdf89w=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];

  nativeBuildInputs =
    with pkgs;
    main-kernel.moduleBuildDependencies
    ++ [
      clang
      llvm
      lld
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
})

{
  inputs,
  kernel,
  lib,
  ...
}:
{
  kernel.lib.config-gen =
    {
      isArm ? false,
      isClang ? true,
      disableDenial ? false,
      structConfig,
      config,
      patches,
      pkgs,
      src,
    }:
    let
      arch = "ARCH=${if isArm then "arm64" else "x86"}";
    in
    pkgs.stdenvNoCC.mkDerivation {
      name = "linux-config-gen";
      inherit patches src;
      LLVM = if isClang then "1" else null;
      RUST_LIB_SRC = "${pkgs.rustPlatform.rustLibSrc}";
      dontFixup = true;

      nativeBuildInputs =
        with pkgs;
        [
          stdenv.cc
          bison
          flex
          rustc
          pahole
        ]
        ++ (lib.optionals isClang [
          (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { }).stdenvLLVM
          llvm
          clang
          lld
        ]);

      makeFlags = [
        arch
        "RUSTC=${pkgs.rustc}/bin/rustc"
        "BINDGEN=${pkgs.rust-bindgen}/bin/bindgen"
      ]
      ++ (lib.optionals (pkgs.stdenv.hostPlatform != pkgs.stdenv.buildPlatform) [
        "CROSS_COMPILE=${pkgs.stdenv.cc.targetPrefix}"
      ]);

      configurePhase = ''
        cp ${config} .config && chmod +w .config
        cp ${pkgs.writeText "kernel-gen-config" ''
          ${structConfig}
          ${(lib.optionalString (!disableDenial) kernel.config.denial.all)}
        ''} .gen_config
      '';

      buildPhase = ''
        ${arch} scripts/kconfig/merge_config.sh -m .config .gen_config &> /dev/null
        make ${arch} $makeFlags olddefconfig
      '';

      installPhase = ''
        ${kernel.config.cleaner}
        cp .config $out
      '';
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

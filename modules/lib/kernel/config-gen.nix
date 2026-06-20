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
      inherit src;
      LLVM = if isClang then "1" else null;
      RUST_LIB_SRC = "${pkgs.rustPlatform.rustLibSrc}";
      PATCHES_FILE = pkgs.writeText "kernel-patches-list" (pkgs.lib.concatStringsSep "\n" patches);
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

      prePatch = ''
        while IFS= read -r patch_path || [ -n "$patch_path" ]; do
        if [ -n "$patch_path" ]; echo "Applying: $(basename "$patch_path")"; then patch -p1 < "$patch_path"; fi
        done < "$PATCHES_FILE"
      '';

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
        ${kernel.config.cleaner.cmd}
        cp .config $out
      '';
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

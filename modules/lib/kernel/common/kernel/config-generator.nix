{
  inputs,
  kernel,
  lib,
  ...
}:
{
  kernel.lib.config-generator =
    {
      pkgs,
      patches ? [ ],
      src,
      isClang ? false,
      isArm ? false,
      denialConfig,
      miscDenialConfig ? "",
      structConfig,
      config,
    }:
    pkgs.stdenv.mkDerivation {
      name = "linux-config";
      inherit patches src;
      LLVM = if isClang then "1" else null;
      stdenv =
        if isClang then
          (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { }).stdenvLLVM
        else
          pkgs.stdenv;

      dontFixup = true;

      nativeBuildInputs =
        with pkgs;
        [
          bison
          flex
          perl
        ]
        ++ (lib.optionals isClang [
          llvm_20
          clang_20
          lld_20
        ]);

      makeFlags =
        (lib.optionals isArm [ "ARCH=arm64" ])
        ++ (lib.optionals (pkgs.stdenv.hostPlatform != pkgs.stdenv.buildPlatform) [
          "CROSS_COMPILE=${pkgs.stdenv.cc.targetPrefix}"
        ]);

      configurePhase = ''
        cp ${config} .config && chmod +w .config
        ${miscDenialConfig}
      '';

      buildPhase = ''
        ${structConfig}
        ${denialConfig}
        scripts/kconfig/merge_config.sh -m .config .gen_config &> /dev/null
        make $makeFlags olddefconfig
      '';

      installPhase = ''
        ${kernel.lib.prune.script}
        cp .config $out
      '';
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

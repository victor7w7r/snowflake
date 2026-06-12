{ inputs, lib, ... }:
{
  kernel.lib.config-generator =
    {
      pkgs,
      patches ? [ ],
      src,
      isClang ? false,
      isArm ? false,
      structConfig,
      config,
    }:
    pkgs.stdenvNoCC.mkDerivation {
      name = "linux-config";
      inherit src patches;
      nativeBuildInputs = with pkgs; [
        bison
        flex
        perl
        gmp
        libmpc
        mpfr
      ];

      phases = [
        "unpackPhase"
        "buildPhase"
        "installPhase"
      ];

      makeFlags =
        (lib.optionals isArm [ "ARCH=arm64" ])
        ++ (lib.optionals (pkgs.stdenv.hostPlatform != pkgs.stdenv.buildPlatform) [
          "CROSS_COMPILE=${pkgs.stdenv.cc.targetPrefix}"
        ]);

      #scripts/config ${lib.concatStringsSep " " config}
      buildPhase = ''
        cp ${config} .config
        export buildRoot="build"

        mkdir -p $buildRoot
        make O=$buildRoot ARCH=${if isArm then "arm64" else "x86_64"} olddefconfig
        patchShebangs scripts/config

        ${structConfig}
        make $makeFlags olddefconfig
      '';
    }
    // lib.optionalAttrs isClang {
      LLVM = "1";
      stdenv = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { }).stdenvLLVM;
      nativeBuildInputs = with pkgs; [
        llvm_20
        clang_20
        lld_20
      ];
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

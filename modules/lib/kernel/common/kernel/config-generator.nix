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
    pkgs.stdenv.mkDerivation {
      name = "linux-config";
      inherit src patches;

      nativeBuildInputs =
        with pkgs;
        [
          bison
          flex
          perl
          #gmp
          #libmpc
          #mpfr
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

      installPhase = ''
        sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
        cp .config $out
      '';

      buildPhase = ''
        cp ${config} .config && chmod +w .config
        patchShebangs scripts/config

        ${structConfig}
        scripts/kconfig/merge_config.sh -m .config .gen_config &> /dev/null

        make $makeFlags savedefconfig
        mv defconfig .config

        make $makeFlags olddefconfig
      '';
    }
    // lib.optionalAttrs isClang {
      LLVM = "1";
      stdenv = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { }).stdenvLLVM;
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

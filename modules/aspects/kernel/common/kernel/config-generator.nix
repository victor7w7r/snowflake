{ lib, ... }:
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
    let
      stdenv = pkgs.stdenv;
    in
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
        lib.optionals isArm [ "ARCH=arm64" ] ++ lib.optionals stdenv.hostPlatform
        != stdenv.buildPlatform [ "CROSS_COMPILE=${stdenv.cc.targetPrefix}" ];

      installPhase = ''
        mkdir -p $out
        cp $buildRoot/.config $out/original.config
      '';

      #scripts/config ${lib.concatStringsSep " " config}
      buildPhase = ''
        cp ${config} .config
        export buildRoot="build"

        mkdir -p $buildRoot
        make O=$buildRoot ARCH=${if isArm then "arm64" else "x86_64"} olddefconfig
        patchShebangs scripts/config

        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (option: value: ''
            echo "  CONFIG_${option}=${value}"
            sed -i "/^CONFIG_${option}/d" .config
            echo "CONFIG_${option}=${value}" >> .config
          '') structConfig
        )}

        make $makeFlags olddefconfig
      '';
    };
  /*
    lib.optionalAttrs isClang {
      LLVM = "1";
        stdenv = helpers.stdenvLLVM;
          pkgs.ccacheStdenv.override {
           stdenv = helpers.stdenvLLVM;
           };

           nativeBuildInputs =
            [
              llvm_20
              clang_20
              lld_20
            ];
    };
  */
}

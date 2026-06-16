{
  inputs,
  kernel,
  lib,
  ...
}:
{
  kernel.lib.config-gen =
    pkgs:
    pkgs.stdenv.mkDerivation {
      name = "linux-config-gen";
      patches = kernel.lib.params.patches;
      src = kernel.lib.params.src;
      LLVM = if kernel.lib.params.isClang then "1" else null;
      stdenv =
        if kernel.lib.params.isClang then
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
        (lib.optionals kernel.lib.params.isArm [ "ARCH=arm64" ])
        ++ (lib.optionals (pkgs.stdenv.hostPlatform != pkgs.stdenv.buildPlatform) [
          "CROSS_COMPILE=${pkgs.stdenv.cc.targetPrefix}"
        ]);

      configurePhase =
        let
          gen = kernel.lib.utils.gen-config {
            inherit pkgs;
            configContent = ''
              ${kernel.lib.params.structConfig}
              ${kernel.lib.denial.all}
            '';
          };
        in
        ''
          cp ${kernel.lib.params.config} .config && chmod +w .config
          cp ${gen} .gen_config
        '';

      buildPhase = ''
        scripts/kconfig/merge_config.sh -m .config .gen_config &> /dev/null
        make $makeFlags olddefconfig
      '';

      installPhase = ''
        sed -i '/^[[:space:]]*#/d; /^[[:space:]]*$/d' .config
        cp .config $out
      '';
    };
}
/*
  pkgs.ccacheStdenv.override {
  stdenv = helpers.stdenvLLVM;
  };
*/

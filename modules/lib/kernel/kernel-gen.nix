{ lib, inputs, ... }:
{
  kernel.lib.kernel-gen =
    {
      localVer,
      configfile,
      patches,
      pkgs,
      isClang ? true,
      isArm ? false,
      src,
      version,
    }:
    let
      helpers = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { });
      kernel-result =
        (pkgs.linuxManualConfig {
          inherit src configfile;
          allowImportFromDerivation = false;
          version = "${version}-v7w7r-${localVer}";
          modDirVersion = "${version}-v7w7r-${localVer}";
          stdenv = if isClang then helpers.stdenvLLVM else pkgs.stdenv;

          kernelPatches = map (file: {
            name = baseNameOf (toString file);
            patch = file;
          }) patches;

          extraMakeFlags = [
            "LOCALVERSION=-v7w7r-${localVer}"
            "NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING=1"
            "NIX_ENFORCE_NO_NATIVE=0"
            #"KCFLAGS=-Wno-unknown-warning-option -Wno-ignored-optimization-argument"
            #"CC=ccache cc"
            #"HOSTCC=ccache cc"
          ];
        }).overrideAttrs
          (attrs: {
            passthru = attrs.passthru // {
              configure = configfile;
              features = lib.optionalAttrs (!isArm) {
                ia32Emulation = true;
                netfilterRPFilter = true;
                efiBootStub = true;
              };
            };
          });
    in
    {
      kernel = kernel-result;
      packages =
        if isClang then
          helpers.kernelModuleLLVMOverride (pkgs.linuxPackagesFor kernel-result)
        else
          pkgs.linuxPackagesFor kernel-result;
    };
}
/*
  lib.optionalAttrs isClang {
    nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.ccache ];
  };
  }
*/

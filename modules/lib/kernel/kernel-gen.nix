{ inputs, ... }:
{
  kernel.lib.kernel-gen =
    {
      localVer,
      configfile,
      patches,
      pkgs,
      isClang ? true,
      src,
      version,
    }:
    let
      helpers = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { });
      kernel-result = (
        pkgs.linuxManualConfig {
          inherit src configfile;
          pname = "linux-v7w7r-${localVer}";
          modDirVersion = "${version}-v7w7r-${localVer}";
          version = "${version}-v7w7r-${localVer}";
          stdenv = if isClang then helpers.stdenvLLVM else pkgs.stdenv;

          checkConfig = false;

          kernelPatches = map (file: {
            name = baseNameOf (toString file);
            patch = file;
          }) patches;

          features = {
            ia32Emulation = true;
            netfilterRPFilter = true;
            efiBootStub = true;
          };

          extraMakeFlags = [
            "LOCALVERSION=-v7w7r-${localVer}"
            "NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING=1"
            "NIX_ENFORCE_NO_NATIVE=0"
            #"KCFLAGS=-Wno-unknown-warning-option -Wno-ignored-optimization-argument"
            #"CC=ccache cc"
            #"HOSTCC=ccache cc"
          ];
        }
      );
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

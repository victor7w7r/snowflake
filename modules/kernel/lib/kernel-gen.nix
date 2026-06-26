{ inputs, lib, ... }:
{
  kernel.lib.kernel-gen =
    {
      localVer,
      extraConfig,
      patches,
      pkgs,
      isArm ? false,
      src,
      version,
    }:
    let
      helpers = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { });
      kernel = (
        pkgs.buildLinux {
          pname = "linux-v7w7r-${localVer}";
          inherit extraConfig src;
          version = "${version}-v7w7r-${localVer}";
          modDirVersion = "${version}-v7w7r-${localVer}";
          defconfig = "x86_64_defconfig";
          stdenv = helpers.stdenvLLVM;
          kernelPatches = map (file: {
            name = baseNameOf (toString file);
            patch = file;
          }) patches;

          features = lib.optionalAttrs (!isArm) {
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
      inherit kernel;
      packages = helpers.kernelModuleLLVMOverride (pkgs.linuxPackagesFor kernel);
    };
}
/*
  lib.optionalAttrs isClang {
    nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.ccache ];
  };
  }
*/

{ inputs, lib, ... }:
{
  kernel.lib.kernel-gen =
    {
      localVer,
      configfile,
      patches,
      pkgs,
      isArm ? false,
      src,
      version,
    }:
    let
      helpers = (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { });
      base = (
        pkgs.linuxManualConfig {
          inherit src configfile;
          allowImportFromDerivation = false;
          version = "${version}-v7w7r-${localVer}";
          modDirVersion = "${version}-v7w7r-${localVer}";
          stdenv = helpers.stdenvLLVM;

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
        }
      );

      kernel = base.overrideAttrs (attrs: {
        outputs = [
          "out"
          "dev"
        ];
        passthru = attrs.passthru // {
          configure = configfile;
          features = lib.optionalAttrs (!isArm) {
            ia32Emulation = true;
            netfilterRPFilter = true;
            efiBootStub = true;
          };
        };
        postInstall = (attrs.postInstall or "") + ''
          mkdir -p $dev
        '';
      });
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

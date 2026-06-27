{
  inputs,
  kernel,
  lib,
  ...
}:
{
  kernel.lib.kernel-gen =
    {
      localVer,
      config,
      extraConfig,
      patches,
      pkgs,
      isArm ? false,
      src,
      version,
    }:
    let
      helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };
      base = pkgs.buildLinux {
        pname = "linux-v7w7r-${localVer}";
        inherit src;
        extraConfig = kernel.lib.concat-config {
          config = extraConfig ++ kernel.config.denial.all ++ (kernel.config.denial.dynamic config);
          isString = true;
        };
        version = "${version}-v7w7r-${localVer}";
        modDirVersion = "${version}-v7w7r-${localVer}";
        stdenv = helpers.stdenvLLVM;
        ignoreConfigErrors = true;

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
      };
    in
    {
      kernel = base;
      packages = base |> pkgs.linuxPackagesFor |> helpers.kernelModuleLLVMOverride;
    };
}
/*
  lib.optionalAttrs isClang {
    nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.ccache ];
  };
  }
*/

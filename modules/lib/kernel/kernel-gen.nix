{ inputs, ... }:
{
  kernel.lib.kernel-gen =
    pkgs:
    let
      kernel =
        (pkgs.linuxManualConfig {
          src = kernel.lib.params.src;
          configfile = kernel.lib.params.configfile;
          pname = "linux-v7w7r-${kernel.lib.params.localVer}";
          modDirVersion = "${kernel.lib.params.version}-v7w7r-${kernel.lib.params.localVer}";
          version = "${kernel.lib.params.version}-v7w7r-${kernel.lib.params.localVer}";
          kernelPatches = map (file: {
            name = baseNameOf (toString file);
            patch = file;
          }) kernel.lib.params.patches;

          extraMakeFlags = [
            "LOCALVERSION=v7w7r-${kernel.lib.params.localVer}"
            "NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING=1"
            "NIX_ENFORCE_NO_NATIVE=0"
            #"KCFLAGS=-Wno-unknown-warning-option -Wno-ignored-optimization-argument"
            #"CC=ccache cc"
            #"HOSTCC=ccache cc"
          ];
        }
          /*
            lib.optionalAttrs isClang {
              nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.ccache ];
              stdenv = pkgs.ccacheStdenv.override { stdenv = helpers.stdenvLLVM; };
              kconfigToNix = pkgs.callPackage ./generated/generate.nix { inherit configure; };
              };
            }
          */
        ).overrideAttrs
          (attrs: {
            features = {
              ia32Emulation = true;
              netfilterRPFilter = true;
              efiBootStub = true;
            };
          });
      llvm-override =
        (pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { }).kernelModuleLLVMOverride;
    in
    {
      inherit kernel;
      packages =
        if kernel.lib.params.isClang then
          llvm-override (pkgs.linuxPackagesFor kernel)
        else
          pkgs.linuxPackagesFor kernel;
    };
}

{ lib, ... }:
{
  kernel.lib.kernel-generator =
    {
      pkgs,
      src,
      patches,
      version,
      localVer ? "",
      isClang ? false,
      configfile,
      config ? null,
    }:
    (
      pkgs.linuxManualConfig {
        inherit
          src
          configfile
          config
          ;
        pname = "linux-v7w7r-${localVer}";
        modDirVersion = "${version}-v7w7r-${localVer}";
        version = "${version}-v7w7r-${localVer}";
        kernelPatches = map (file: {
          name = baseNameOf (toString file);
          patch = file;
        }) patches;

        extraMakeFlags = [
          "LOCALVERSION=v7w7r-${localVer}"
          "NIX_CC_WRAPPER_SUPPRESS_TARGET_WARNING=1"
          "NIX_ENFORCE_NO_NATIVE=0"
          #"KCFLAGS=-Wno-unknown-warning-option -Wno-ignored-optimization-argument"
          #"CC=ccache cc"
          #"HOSTCC=ccache cc"
        ];
      }

      // lib.optionalAttrs isClang {
        /*
          #nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.ccache ];
          stdenv = pkgs.ccacheStdenv.override {
          stdenv = helpers.stdenvLLVM;
          kconfigToNix = pkgs.callPackage ./generated/generate.nix { inherit configure; };
          };
        */
      }
    ).overrideAttrs
      (attrs: {
        passthru = attrs.passthru // {
          features = {
            ia32Emulation = true;
            netfilterRPFilter = true;
            efiBootStub = true;
          };
        };
      });
}
#  packages = pkgs.linuxPackagesFor kernel;

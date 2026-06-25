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

      kernel =
        base.overrideAttrs (attrs: {
          passthru = attrs.passthru // {
            configure = configfile;
            features = lib.optionalAttrs (!isArm) {
              ia32Emulation = true;
              netfilterRPFilter = true;
              efiBootStub = true;
            };
            dev = kernel;
          };
          postInstall = (attrs.postInstall or "") + ''
            TARGET_MOD_DIR="$out/lib/modules/${version}-v7w7r-${localVer}"
            mkdir -p "$TARGET_MOD_DIR"
            rm -rf "$TARGET_MOD_DIR/build"
            rm -rf "$TARGET_MOD_DIR/source"
            DEVELOPMENT_DIR="$out/share/linux-kernel"
            mkdir -p "$DEVELOPMENT_DIR"
            cp -a . "$DEVELOPMENT_DIR/"
            make -C "$DEVELOPMENT_DIR" modules_prepare EXTRA_CFLAGS="-Wno-error" 2>/dev/null || true
            ln -s "$DEVELOPMENT_DIR" "$TARGET_MOD_DIR/build"
            ln -s "$DEVELOPMENT_DIR" "$TARGET_MOD_DIR/source"
          '';
        })
        // {
          dev = kernel;
        };
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

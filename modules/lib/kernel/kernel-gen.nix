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

          kernelPatches =
            map (file: {
              name = baseNameOf (toString file);
              patch = file;
            }) patches
            ++ [
              {
                name = "nixos-required-configs";
                patch = null;
                extraConfig = ''
                  # Requisitos críticos de Systemd y Booteo
                  DEVTMPFS y
                  DEVTMPFS_MOUNT y
                  CGROUPS y
                  INOTIFY_USER y
                  SIGNALFD y
                  TIMERFD y
                  EPOLL y
                  SYSFS y
                  PROC_FS y
                  FHANDLE y
                  BINFMT_ELF y
                  BLK_DEV_INITRD y

                  NET y
                  UNIX y
                  SWAP y
                  TMPFS y
                  TMPFS_POSIX_ACL y
                  TMPFS_XATTR y
                  ZRAM y

                  SECCOMP y
                  CRYPTO_USER_API_HASH y
                  CRYPTO_HMAC y
                  CRYPTO_SHA256 y
                  DMIID y
                  AUTOFS_FS y
                '';
              }
            ];

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

{ kernel, ... }:
{
  kernel.oneplus.nixos = {
    nixpkgs.overlays = [
      /*
        kconfigFile = pkgs.writeText "kconfig-mobile" (
          lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: value: "${name}=${value}") (import ./config.aarch64-linux.nix)
          )
        );
      */
      (
        _: prev:
        let
          src = (kernel.lib.sdm845 { inherit pkgs; });
          version = kernel.lib.version { inherit src; };
          localVer = "-sdm845";
          oneplus-config = kernel.config.modules-generator {
            config = ./sdm845.config;
            inherit pkgs src;
          };
          pkgs = prev;
        in
        {
          inherit oneplus-config;
          oneplus-kernel =
            (pkgs.mobile-nixos.kernel-builder {
              patches = [ ];
              inherit src;
              configfile = ./sdm845.config;

              nativeBuildInputs = with pkgs; [
                python3
                zstd
                kmod
                gzip
              ];

              isModular = true;

              version = "${version}${localVer}";
              modDirVersion = "${version}${localVer}";
              makeFlags = [ "LOCALVERSION=${localVer}" ];
              makeImageDtbWith = "qcom/sdm845-oneplus-fajita.dtb";
              isCompressed = "gz";

              postInstall = ''
                mkdir -p $out
                cp -v "$buildRoot/arch/arm64/boot/Image.gz" "$out/Image.gz"
                ln -sv Image.gz "$out/vmlinuz" || true
                cp .config $out/config-${version}
                depmod -b "$out" -F "$buildRoot/System.map" "${version}${localVer}"
              '';
              postPatch = ''
                rm -f localversion*
                sed -i 's/localversion_next=.*//' scripts/setlocalversion
                echo "" > .scmversion
              '';
            }).overrideAttrs
              (attrs: {
                postConfigure = ''
                    cat >> $buildRoot/.config <<EOF
                  CONFIG_DEVTMPFS=y
                  CONFIG_RAMFS=y
                  EOF
                '';
                installTargets = [ "modules_install" ];
              });
        }
      )
    ];
  };
}

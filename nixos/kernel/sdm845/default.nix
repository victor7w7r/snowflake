{
  lib,
  pkgs,
  kernelData,
  ...
}:
let
  configure = pkgs.callPackage ./configure.nix { inherit kernelData; };
  kconfigToNix = pkgs.callPackage ../generated/generate.nix { inherit configure; };
  kconfigFile = pkgs.writeText "kconfig-mobile" (
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList (name: value: "${name}=${value}") (import ./config.aarch64-linux.nix)
    )
  );
  build =
    let
      kernelFunc =
        { ... }:
        (pkgs.mobile-nixos.kernel-builder {
          patches = [ ];
          inherit (configure) src;
          configfile = ./sdm845.config;

          nativeBuildInputs = with pkgs; [
            python3
            zstd
            kmod
            gzip
          ];

          isModular = true;

          version = "${configure.version}${configure.passthru.localVer}";
          modDirVersion = "${configure.version}${configure.passthru.localVer}";
          makeFlags = [ "LOCALVERSION=${configure.passthru.localVer}" ];
          makeImageDtbWith = "qcom/sdm845-oneplus-fajita.dtb";
          isCompressed = "gz";

          postInstall = ''
            mkdir -p $out
            cp -v "$buildRoot/arch/arm64/boot/Image.gz" "$out/Image.gz"
            ln -sv Image.gz "$out/vmlinuz" || true
            cp .config $out/config-${configure.version}
            depmod -b "$out" -F "$buildRoot/System.map" "${configure.version}${configure.passthru.localVer}"
          '';
          postPatch = ''
            rm -f localversion*
            sed -i 's/localversion_next=.*//' scripts/setlocalversion
            echo "" > .scmversion
          '';
        }).overrideAttrs
          (attrs: {
            installTargets = [ "modules_install" ];
            passthru = attrs.passthru // {
              inherit kconfigToNix kconfigFile configure;
            };
          });
    in
    (lib.makeOverridable kernelFunc) { };
in
{
  inherit build;
  packages = pkgs.linuxPackagesFor build;
}

{
  pkgs,
  kernelData,
  ...
}:
let
  configure = pkgs.callPackage ./configure.nix { inherit kernelData; };
  kconfigToNix = pkgs.callPackage ../generated/generate.nix { inherit configure; };
  /*
    postInstall = ''
      mkdir -p $out

      cp -v "$buildRoot/arch/arm64/boot/Image.gz" "$out/Image.gz"

      ln -sv Image.gz "$out/vmlinuz" || true
      cp .config $out/config-${configure.version}

      depmod -b "$out" -F "$buildRoot/System.map" "${configure.version}"
    '';
  */
  /*
    patches = configure.passthru.patches;
    kconfigFile = pkgs.writeText "kconfig-mobile" (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "${name}=${value}") (import ./config.aarch64-linux.nix)
      )
    );
  */
  build =
    (pkgs.mobile-nixos.kernel-builder {
      inherit (configure) src;
      configfile = ./sdm845.config;
      isModular = false;
      isCompressed = "gz";
      version = "${configure.version}${configure.passthru.localVer}";
      modDirVersion = "${configure.version}${configure.passthru.localVer}";
      makeImageDtbWith = "qcom/sdm845-oneplus-fajita.dtb";
    })

    .overrideAttrs
      (attrs: {
        passthru = attrs.passthru // {
          inherit kconfigToNix configure;
        };
        #installFlags = [ "INSTALL_MOD_PATH=$out" ];
        configurePhase = ''
          scripts/config --enable CONFIG_BRIDGE
        '';
      });

in
{
  inherit build;
  packages = pkgs.linuxPackagesFor build;
}

{
  lib,
  pkgs,
  kernelData,
  ...
}:
let
  version = rec {
    file = "${fetch.sdm845}/Makefile";
    version = toString (builtins.match ".+VERSION = ([0-9]+).+" (builtins.readFile file));
    patchlevel = toString (builtins.match ".+PATCHLEVEL = ([0-9]+).+" (builtins.readFile file));
    sublevel = toString (builtins.match ".+SUBLEVEL = ([0-9]+).+" (builtins.readFile file));
    extraversion = toString (builtins.match ".+EXTRAVERSION = ([a-z0-9-]+).+" (builtins.readFile file));
    string = "${
      version + "." + patchlevel + "." + sublevel + (lib.optionalString (extraversion != "") extraversion)
    }";
  };
  majorMinor = lib.versions.majorMinor version.string;

  #configure = pkgs.callPackage ./configure.nix { inherit kernelData; };
  #kconfigToNix = pkgs.callPackage ../generated/generate.nix { inherit configure; };
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
  fetch = (pkgs.callPackage ../fetch.nix { inherit kernelData majorMinor; });
  build = (
    pkgs.mobile-nixos.kernel-builder {
      src = fetch.sdm845;
      configfile = ./sdm845.config;
      isModular = false;
      isCompressed = "gz";
      version = version.string;
      #modDirVersion = "${configure.version}${configure.passthru.localVer}";
      makeImageDtbWith = "qcom/sdm845-oneplus-fajita.dtb";
    }
  );

  /*
    .overrideAttrs
    (attrs: {
      passthru = attrs.passthru // {
        inherit kconfigToNix configure;
      };
        installFlags = [ "INSTALL_MOD_PATH=$out" ];

        configurePhase = ''
          runHook preConfigure

          cp ${kconfigFile} .config
          chmod +w .config
          make olddefconfig

          runHook postConfigure
          '';
    });
  */
in
{
  inherit build;
  packages = pkgs.linuxPackagesFor build;
}

{ kernel, ... }:
{
  kernel.hosts.handheld =
    pkgs:
    let
      src = (kernel.linux.injector pkgs).cachyos;
      version = kernel.lib.calc-version pkgs src;
      patchesData = (kernel.patches.injector pkgs);
      cachyosPatches = (patchesData.cachyos version.majorMinor);
      bunkerPatches = patchesData.bunker;
      tachyonPatches = patchesData.tachyon;
      patches =
        cachyosPatches.common
        ++ cachyosPatches.handheld
        ++ tachyonPatches.common
        ++ tachyonPatches.gaming
        ++ bunkerPatches.common
        ++ patchesData.asus;

      handheld-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        config = (kernel.linux.injector pkgs).kConfig false;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            (cmdline { isAmd = true; })
            default
            freq.high
            hardware.desktop-wserial
            net
            storage.bcachefs
            storage.ntfs
            storage.not-raid
            storage.not-xfs
            vendor.amd
          ]);
      };

      generated = kernel.lib.kernel-gen {
        inherit pkgs src patches;
        localVer = "handheld-native";
        isArm = false;
        version = version.string;
        configfile = handheld-config;
      };
    in
    {
      inherit handheld-config;
      handheld-kernelPackages = generated.packages;
      /*
        let
          pkgsSet = generated.packages;
          keys = builtins.attrNames pkgsSet.kernel;
        in
        builtins.trace ("Atributos encontrados: " + builtins.concatStringsSep ", " keys) pkgsSet;
      */
      handheld-kernel = generated.kernel;
    };
}

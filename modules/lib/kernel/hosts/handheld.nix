{ kernel, ... }:
{
  kernel.hosts.handheld =
    pkgs:
    let
      libs = kernel.lib.injector pkgs;
      src = (kernel.linux.injector pkgs).cachyos;
      version = libs.calc-version src;
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

      handheld-config = libs.config-gen {
        inherit patches src;
        config = (kernel.linux.injector pkgs).kConfig false;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            fs.bcachefs
            freq.high
            general
            not-raid
            sbc.not-serial
            sbc.not-gpio
            sbc.not-phone
            vendor.not-intel
            x86
            (cmdline { isAmd = true; })
          ]);
      };

      generated = libs.kernel-gen {
        inherit src patches;
        localVer = "handheld-native";
        version = version.string;
        configfile = handheld-config;
      };
    in
    {
      inherit handheld-config;
      handheld-kernelPackages = generated.packages;
      handheld-kernel = generated.kernel;
    };
}

{ kernel, ... }:
{
  kernel.hosts.main =
    pkgs:
    let
      libs = kernel.lib.injector pkgs;
      src = (kernel.linux.injector pkgs).cachyos;
      version = libs.calc-version src;
      patches =
        with (kernel.patches.injector pkgs);
        (cachyos version.majorMinor).common ++ tachyon.common ++ tachyon.notGaming ++ bunker.common;
      main-config = libs.config-gen {
        inherit patches src;
        config = (kernel.linux.injector pkgs).kConfig false;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            fs.bcachefs
            freq.high
            general
            sbc.not-arm
            sbc.not-gpio
            sbc.not-phone
            not-raid
            vendor.not-amd
            (cmdline {
              isIntel = true;
              isSata = true;
              extra = "video=DP-3:1600x900@60";
            })
          ]);
      };
      generated = libs.kernel-gen {
        inherit src patches;
        localVer = "native";
        version = version.string;
        configfile = main-config;
      };
    in
    {
      inherit main-config;
      main-kernelPackages = generated.packages;
      main-kernel = generated.kernel;
    };
}

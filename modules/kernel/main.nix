{ kernel, ... }:
{
  kernel.hosts.main =
    pkgs:
    let
      src = (kernel.linux.injector pkgs).cachyos;
      version = kernel.lib.calc-version pkgs src;
      patches =
        with (kernel.patches.injector pkgs);
        (cachyos version.majorMinor).common ++ tachyon.common ++ tachyon.notGaming ++ bunker.common;
      main-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        isArm = false;
        config = (kernel.linux.injector pkgs).kConfig false;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            (cmdline {
              isIntel = true;
              isSata = true;
              extra = "video=DP-3:1600x900@60";
            })
            default
            freq.high
            hardware.desktop
            hardware.serial
            net
            storage.bcachefs
            storage.ntfs
            storage.not-raid
            storage.xfs
            vendor.intel
          ]);
      };
      generated = kernel.lib.kernel-gen {
        inherit pkgs src patches;
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

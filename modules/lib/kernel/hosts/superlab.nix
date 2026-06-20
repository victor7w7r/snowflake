{ kernel, ... }:
{
  kernel.hosts.superlab =
    pkgs:
    let
      libs = kernel.lib.injector pkgs;
      src = (kernel.linux.injector pkgs).cachyos;
      version = libs.calc-version src;
      patchesData = (kernel.patches.injector pkgs);
      cachyosPatches = (patchesData.cachyos version.majorMinor);
      tachyonPatches = patchesData.tachyon;
      bunkerPatches = patchesData.bunker;

      patches =
        cachyosPatches.common
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming
        ++ bunkerPatches.common
        ++ patchesData.armbian.rochchip-patches;

      superlab-config = libs.config-gen {
        inherit patches src;
        isArm = true;
        config = "${patchesData.armbian.source}/config/kernel/linux-rockchip64-current.config";
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            (cmdline { })
            default
            freq.high
            hardware.not-phone
            net
            storage.bcachefs
            storage.not-cdrom
            storage.f2fs
            storage.ntfs
            storage.not-raid
            torage.not-xfs
            vendor.not-vendor
          ]);
      };

      generated = libs.kernel-gen {
        inherit src patches;
        isClang = false;
        version = version.string;
        localVer = "rk";
        configfile = superlab-config;
      };
    in
    {
      inherit superlab-config;
      pizero-kernelPackages = generated.packages;
      pizero-kernel = generated.kernel;
    };
}

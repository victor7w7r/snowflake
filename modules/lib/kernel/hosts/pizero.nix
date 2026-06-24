{ kernel, ... }:
{
  kernel.hosts.pizero =
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
        ++ cachyosPatches.hardened
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming
        ++ bunkerPatches.common
        ++ bunkerPatches.hardened
        ++ patchesData.armbian.sunxi-patches;

      pizero-config = libs.config-gen {
        inherit patches src;
        isArm = true;
        config = "${patchesData.armbian.source}/config/kernel/linux-sunxi64-current.config";
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            (cmdline { })
            default
            freq.low
            hardware.not-phone
            net
            storage.not-btrfs
            storage.not-cdrom
            storage.f2fs
            storage.not-ntfs
            storage.not-raid
            storage.xfs
            vendor.not-vendor
          ]);
      };

      generated = libs.kernel-gen {
        inherit src patches;
        isClang = false;
        version = version.string;
        localVer = "sunxi-hardened";
        configfile = pizero-config;
      };
    in
    {
      inherit pizero-config;
      pizero-kernelPackages = generated.packages;
      pizero-kernel = generated.kernel;
    };
}

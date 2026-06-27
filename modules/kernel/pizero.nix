{ kernel, ... }:
{
  kernel.hosts.pizero =
    pkgs:
    let
      src = (kernel.linux.injector pkgs).cachyos;
      version = kernel.lib.calc-version pkgs src;
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

      config = with kernel.config.modules; [
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
      ];

      generated = kernel.lib.kernel-gen {
        inherit pkgs src patches;
        localVer = "sunxi-hardened";
        config = "${patchesData.armbian.source}/config/kernel/linux-sunxi64-current.config";
        extraConfig = config ++ kernel.config.denial.all;
      };
    in
    {
      pizero-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        isArm = true;
        config = "${patchesData.armbian.source}/config/kernel/linux-sunxi64-current.config";
        extraConfig = config;
      };
      pizero-kernelPackages = generated.packages;
      pizero-kernel = generated.kernel;
    };
}

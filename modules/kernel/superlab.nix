{ kernel, ... }:
{
  kernel.hosts.superlab =
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
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming
        ++ bunkerPatches.common
        ++ patchesData.armbian.rockchip-patches;

      config = with kernel.config.modules; [
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
        storage.not-xfs
        vendor.not-vendor
      ];

      generated = kernel.lib.kernel-gen {
        inherit pkgs src patches;
        version = version.string;
        localVer = "rockchip";
        extraConfig = (kernel.lib.concat-config-str (config ++ kernel.config.denial.all));
      };
    in
    {
      superlab-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        isArm = true;
        config = "${patchesData.armbian.source}/config/kernel/linux-rockchip64-current.config";
        structConfig = (kernel.lib.concat-config config);
      };
      superlab-kernelPackages = generated.packages;
      superlab-kernel = generated.kernel;
    };
}

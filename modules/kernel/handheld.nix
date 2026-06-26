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

      config = with kernel.config.modules; [
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
      ];

      generated = kernel.lib.kernel-gen {
        inherit patches src pkgs;
        localVer = "handheld-native";
        isArm = false;
        version = version.string;
        extraConfig = (kernel.lib.concat-config-str (config ++ kernel.config.denial.all));
      };
    in
    {
      handheld-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        config = (kernel.linux.injector pkgs).kConfig false;
        structConfig = (kernel.lib.concat-config config);
      };
      handheld-kernelPackages = generated.packages;
      handheld-kernel = generated.kernel;
    };
}

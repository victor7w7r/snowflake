{ kernel, ... }:
{
  kernel.hosts.server =
    pkgs:
    let
      src = (kernel.linux.injector pkgs).cachyos;
      version = kernel.lib.calc-version pkgs src;
      patchesData = kernel.patches.injector pkgs;
      cachyosPatches = patchesData.cachyos version.majorMinor;
      tachyonPatches = patchesData.tachyon;
      bunkerPatches = patchesData.bunker;
      patches =
        cachyosPatches.optimization
        ++ cachyosPatches.hardened
        ++ cachyosPatches.governors
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming
        ++ bunkerPatches.common
        ++ bunkerPatches.hardened;

      config = with kernel.config.modules; [
        (cmdline {
          isIntel = true;
          isSata = true;
          isSec = true;
        })
        default
        freq.low
        hardware.desktop
        hardware.serial
        net
        storage.f2fs
        storage.ntfs
        storage.not-cdrom
        storage.xfs
        vendor.intel
      ];

      generated = kernel.lib.kernel-gen {
        inherit pkgs src patches;
        localVer = "server-hardened-native";
        version = version.string;
        config = (kernel.linux.injector pkgs).kConfig false;
        extraConfig = config;
      };
    in
    {
      server-config = kernel.lib.config-gen {
        inherit patches src pkgs;
        config = (kernel.linux.injector pkgs).kConfig true;
        isArm = false;
        extraConfig = config;
      };
      server-kernelPackages = generated.packages;
      server-kernel = generated.kernel;
    };
}

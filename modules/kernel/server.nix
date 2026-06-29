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
    in
    (kernel.lib.v7w7r {
      inherit pkgs src;
      localVer = "server-hardened-native";
      version = version.string;
      config = (kernel.linux.injector pkgs).kConfig false;
      patches =
        cachyosPatches.optimization
        ++ cachyosPatches.hardened
        ++ cachyosPatches.governors
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming
        ++ bunkerPatches.common;
      extraConfig = with kernel.config.modules; [
        (cmdline {
          isIntel = true;
          isSata = true;
          isSec = true;
        })
        default
        freq.low
        hardware.desktop
        hardware.serial
        hardware.native
        net
        storage.f2fs
        storage.ntfs
        storage.not-cdrom
        storage.xfs
        vendor.intel
      ];
    })
    |> (generated: {
      server-config = generated.config;
      server-kernelPackages = generated.packages;
      server-kernel = generated.kernel;
    });
}

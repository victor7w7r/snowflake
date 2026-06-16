{ kernel, ... }:
{
  kernel.host.server =
    pkgs:
    let
      libs = kernel.lib.injector pkgs;
      src = (kernel.linux.injector pkgs).cachyos;
      version = libs.calc-version src;
      patchesData = (kernel.patches.injector pkgs);
      cachyosPatches = (patchesData.cachyos version.majorMinor);
      tachyonPatches = patchesData.tachyon;
      patches =
        cachyosPatches.optimization
        ++ cachyosPatches.hardened
        ++ cachyosPatches.governors
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming;

      server-config = kernel.config.modules-gen {
        inherit patches src;
        config = (kernel.linux.injector pkgs).kConfig true;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.concat-config [
            intel
            blacklist.all
            fs.bcachefs
            fs.overlayfs
            fs.xfs
            general
            lowfreq
            net
            storage.all
            all-debug
            all-vendor
            (cmdline {
              isIntel = true;
              isSata = true;
              isSec = true;
            })
          ]);
      };

      generated = libs.kernel-gen {
        inherit src patches;
        localVer = "server-hardened-native";
        version = version.string;
        configfile = server-config;
      };
    in
    {
      inherit server-config;
      server-kernelPackages = generated.packages;
      server-kernel = generated.kernel;
    };
}

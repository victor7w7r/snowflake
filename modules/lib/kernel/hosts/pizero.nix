{ kernel, lib, ... }:
{
  kernel = {
    lib.params = lib.mkMerge [
      (kernel.lib.params or { })
      {
        hardened = true;
        localVer = "-sunxi-hardened";
      }
    ];

    hosts.pizero =
      pkgs:
      let
        libs = kernel.lib.injector pkgs;
        src = (kernel.linux.injector pkgs).cachyos;
        version = libs.calc-version { inherit src; };
        patchesData = (kernel.patches.injector pkgs);
        cachyosPatches = (patchesData.cachyos version.majorMinor);
        tachyonPatches = patchesData.tachyon;

        patches =
          patchesData.sunxi.patches
          ++ cachyosPatches.hardened
          ++ tachyonPatches.common
          ++ tachyonPatches.notGaming;

        pizero-config = kernel.config.modules-gen {
          inherit patches src;
          config = "${patchesData.sunxi.armbian}/config/kernel/linux-sunxi64-current.config";
          structConfig =
            with kernel.config.modules;
            (kernel.lib.concat-config [
              intel
              blacklist.all
              fs.overlayfs
              fs.xfs
              general
              lowfreq
              net
              storage.zram
              all-debug
              all-vendor
              (cmdline { })
            ]);
        };

        generated = libs.kernel-gen {
          inherit src patches;
          version = version.string;
          configfile = pizero-config;
        };
      in
      {
        inherit pizero-config;
        pizero-kernelPackages = generated.packages;
        pizero-kernel = generated.kernel;
      };
  };
}

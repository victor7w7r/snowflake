{ kernel, lib, ... }:
{
  kernel = {
    lib.params = lib.mkMerge [
      (kernel.lib.params or { })
      {
        isClang = true;
        localVer = "-handheld-native";
      }
    ];

    hosts.handheld =
      pkgs:
      let
        libs = kernel.lib.injector pkgs;
        src = (kernel.linux.injector pkgs).cachyos;
        version = libs.calc-version { inherit src; };
        patchesData = (kernel.patches.injector pkgs);
        cachyosPatches = (patchesData.cachyos version.majorMinor);
        tachyonPatches = patchesData.tachyon;
        patches =
          cachyosPatches.common
          ++ cachyosPatches.handheld
          ++ tachyonPatches.common
          ++ tachyonPatches.gaming
          ++ patchesData.asus;

        handheld-config = libs.config-gen {
          inherit patches src;
          config = (kernel.linux.injector pkgs).kConfig;
          structConfig =
            with kernel.config.modules;
            (kernel.lib.concat-config [
              amd
              blacklist.all
              fs.bcachefs
              fs.overlayfs
              fs.xfs
              general
              highfreq
              net
              zram
              all-debug
              all-vendor
              (cmdline { isAmd = true; })
            ]);
        };

        generated = libs.kernel-gen {
          inherit src patches;
          version = version.string;
          configfile = handheld-config;
        };
      in
      {
        inherit handheld-config;
        handheld-kernelPackages = generated.packages;
        handheld-kernel = generated.kernel;
      };
  };
}

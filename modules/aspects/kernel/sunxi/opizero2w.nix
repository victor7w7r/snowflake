{ kernel, ... }:
{
  kernel.sunxi.nixos = {
    nixpkgs.overlays = [
      (
        _: prev:
        let
          pkgs = prev;
          src = (kernel.lib.linux { inherit pkgs; });
          version = kernel.lib.version { inherit src; };
          cachyosPatches = (
            kernel.patches.cachyos {
              inherit pkgs;
              majorMinor = version.majorMinor;
            }
          );
          sunxi = (kernel.patches.sunxi { inherit pkgs; });
          tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
          patches =
            sunxi.patches ++ cachyosPatches.hardened ++ tachyonPatches.common ++ tachyonPatches.notGaming;
          pizero-config = kernel.lib.config-generator {
            config = "${sunxi.armbian}/config/kernel/linux-sunxi64-current.config";
            structConfig =
              kernel.config.intel
              // kernel.config.blacklist.all
              // kernel.config.fs.overlayfs
              // kernel.config.fs.xfs
              // kernel.config.general
              // kernel.config.lowfreq
              // kernel.config.net
              // kernel.config.storage.zram
              // kernel.config.all-debug
              // kernel.config.all-vendor
              // (kernel.config.cmdline { });
            inherit
              pkgs
              src
              patches
              ;
          };
        in
        {
          inherit pizero-config;
          pizero-kernel = kernel.lib.kernel-generator {
            localVer = "-sunxi-hardened";
            configfile = pizero-config;
            inherit
              pkgs
              src
              patches
              version
              ;
          };
        }
      )
    ];
  };
}

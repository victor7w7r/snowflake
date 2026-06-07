{ kernel, ... }:
{
  kernel.rogally.nixos = {
    nixpkgs.overlays = [
      (
        _: prev:
        let
          pkgs = prev;
          isClang = true;
          src = (kernel.lib.linux { inherit pkgs; });
          version = kernel.lib.version { inherit src; };
          cachyosPatches = (
            kernel.patches.cachyos {
              inherit pkgs;
              majorMinor = version.majorMinor;
            }
          );
          asusPatches = (kernel.patches.asus { inherit pkgs; });
          tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
          patches =
            cachyosPatches.common
            ++ cachyosPatches.handheld
            ++ tachyonPatches.common
            ++ tachyonPatches.gaming
            ++ asusPatches;
          handheld-config = kernel.lib.config-generator {
            config = (kernel.lib.config { inherit pkgs; });
            structConfig =
              kernel.config.amd
              // kernel.config.blacklist.all
              // kernel.config.fs.bcachefs
              // kernel.config.fs.overlayfs
              // kernel.config.fs.xfs
              // kernel.config.general
              // kernel.config.highfreq
              // kernel.config.net
              // kernel.config.zram
              // kernel.config.all-debug
              // kernel.config.all-vendor
              // (kernel.config.cmdline { isAmd = true; });
            inherit
              pkgs
              isClang
              src
              patches
              ;
          };
        in
        {
          inherit handheld-config;
          handheld-kernel = kernel.lib.kernel-generator {
            localVer = "-handheld-native";
            configfile = handheld-config;
            inherit
              pkgs
              src
              isClang
              patches
              version
              ;
          };
        }
      )
    ];
  };
}

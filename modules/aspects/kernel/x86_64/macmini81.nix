{ kernel, ... }:
{
  kernel.macmini81.nixos = {
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
          tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
          patches = cachyosPatches.common ++ tachyonPatches.common ++ tachyonPatches.notGaming;
          main-config = kernel.lib.config-generator {
            config = (kernel.lib.config { inherit pkgs; });
            structConfig =
              kernel.config.intel
              // kernel.config.blacklist.all
              // kernel.config.fs.overlayfs
              // kernel.config.fs.xfs
              // kernel.config.general
              // kernel.config.highfreq
              // kernel.config.net
              // kernel.config.storage.zram
              // kernel.config.all-debug
              // kernel.config.all-vendor
              // (kernel.config.cmdline {
                isIntel = true;
                isSata = true;
                extra = "video=DP-3:1600x900@60";
              });
            inherit
              pkgs
              isClang
              src
              patches
              ;
          };
        in
        {
          inherit main-config;
          main-kernel = kernel.lib.kernel-generator {
            localVer = "-t2-native";
            configfile = main-config;
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

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
          tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
          patches =
            cachyosPatches.optimization
            ++ cachyosPatches.hardened
            ++ cachyosPatches.governors
            ++ tachyonPatches.common
            ++ tachyonPatches.notGaming;
          server-config = kernel.lib.config-generator {
            config = (kernel.lib.config { inherit pkgs; });
            structConfig =
              kernel.config.intel
              // kernel.config.blacklist.all
              // kernel.config.fs.bcachefs
              // kernel.config.fs.overlayfs
              // kernel.config.fs.xfs
              // kernel.config.general
              // kernel.config.lowfreq
              // kernel.config.net
              // kernel.config.storage.all
              // kernel.config.all-debug
              // kernel.config.all-vendor
              // (kernel.config.cmdline {
                isIntel = true;
                isSata = true;
                isSec = true;
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
          inherit server-config;
          server-kernel = kernel.lib.kernel-generator {
            localVer = "-server-hardened-native";
            configfile = server-config;
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

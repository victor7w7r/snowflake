{ kernel, ... }:
{
  kernel.hosts.main =
    pkgs:
    let
      isClang = true;
      src = (kernel.lib.linux { inherit pkgs; });
      version = kernel.lib.utils.calc-version {
        inherit src;
        mkDerivation = pkgs.stdenvNoCC.mkDerivation;
      };
      tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
      patches =
        (kernel.patches.cachyos {
          inherit pkgs;
          majorMinor = version.majorMinor;
        }).common
        ++ tachyonPatches.common
        ++ tachyonPatches.notGaming;

      main-config = kernel.config.modules-gen {
        inherit
          isClang
          patches
          pkgs
          src
          ;
        config = kernel.lib.kConfig { inherit pkgs; };
        denialConfig = kernel.config.denial.all;
        structConfig =
          with kernel.config.modules;
          (kernel.lib.utils.concat-config [
            intel
            fs.overlayfs
            fs.xfs
            general
            highfreq
            net
            not-phone
            storage.zram
            (cmdline {
              isIntel = true;
              isSata = true;
              extra = "video=DP-3:1600x900@60";
            })
          ]);
      };

      generated = kernel.lib.kernel-gen {
        configfile = main-config;
        localVer = "-native";
        version = version.string;
        inherit
          isClang
          patches
          pkgs
          src
          ;
      };
    in
    {
      inherit main-config;
      main-kernelPackages = generated.packages;
      main-kernel = generated.kernel;
    };
}

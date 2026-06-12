{ kernel, lib, ... }:
{
  kernel.macmini81 = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.macmini81.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        isClang = true;
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.version {
          inherit src;
          stdenv = pkgs.stdenvNoCC;
        };
        tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
        patches =
          (kernel.patches.cachyos {
            inherit pkgs;
            majorMinor = version.majorMinor;
          }).common
          ++ tachyonPatches.common
          ++ tachyonPatches.notGaming;

        main-config = kernel.lib.config-generator {
          inherit
            isClang
            patches
            pkgs
            src
            ;
          config = (kernel.lib.config { inherit pkgs; });
          structConfig =
            kernel.lib.config.intel
            // kernel.lib.config.blacklist.all
            // kernel.lib.config.fs.overlayfs
            // kernel.lib.config.fs.xfs
            // kernel.lib.config.general
            // kernel.lib.config.highfreq
            // kernel.lib.config.net
            // kernel.lib.config.storage.zram
            // kernel.lib.config.all-debug
            // kernel.lib.config.all-vendor
            // (kernel.lib.config.cmdline {
              isIntel = true;
              isSata = true;
              extra = "video=DP-3:1600x900@60";
            });
        };

        kernel-gen = kernel.lib.kernel-generator {
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
        main-kernelPackages = kernel-gen.packages;
        main-kernel = kernel-gen.kernel;
      };
  };
}

{ kernel, ... }:
{
  kernel.sunxi = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.sunxi.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.version {
          inherit src;
          stdenv = pkgs.stdenvNoCC;
        };
        cachyosPatches = kernel.patches.cachyos {
          inherit pkgs;
          majorMinor = version.majorMinor;
        };
        sunxi = (kernel.patches.sunxi { inherit pkgs; });
        tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
        patches =
          sunxi.patches ++ cachyosPatches.hardened ++ tachyonPatches.common ++ tachyonPatches.notGaming;

        pizero-config = kernel.lib.config-generator {
          inherit
            pkgs
            src
            patches
            ;
          config = "${sunxi.armbian}/config/kernel/linux-sunxi64-current.config";
          structConfig =
            kernel.lib.config.intel
            // kernel.lib.config.blacklist.all
            // kernel.lib.config.fs.overlayfs
            // kernel.lib.config.fs.xfs
            // kernel.lib.config.general
            // kernel.lib.config.lowfreq
            // kernel.lib.config.net
            // kernel.lib.config.storage.zram
            // kernel.lib.config.all-debug
            // kernel.lib.config.all-vendor
            // (kernel.lib.config.cmdline { });
        };

        kernel-gen = kernel.lib.kernel-generator {
          localVer = "-sunxi-hardened";
          configfile = pizero-config;
          inherit
            pkgs
            src
            patches
            version
            ;
        };
      in
      {
        inherit pizero-config;
        pizero-kernelPackages = kernel-gen.packages;
        pizero-kernel = kernel-gen.kernel;
      };
  };
}

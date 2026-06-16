{ kernel, ... }:
{
  kernel.sunxi = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.sunxi.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.utils.calc-version {
          inherit src;
          stdenv = pkgs.stdenvNoCC.mkDerivation;
        };
        cachyosPatches = kernel.patches.cachyos {
          inherit pkgs;
          majorMinor = version.majorMinor;
        };
        sunxi = (kernel.patches.sunxi { inherit pkgs; });
        tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
        patches =
          sunxi.patches ++ cachyosPatches.hardened ++ tachyonPatches.common ++ tachyonPatches.notGaming;

        pizero-config = kernel.lib.config-gen {
          inherit
            pkgs
            src
            patches
            ;
          config = "${sunxi.armbian}/config/kernel/linux-sunxi64-current.config";
          denialConfig = kernel.lib.denial.all;
          structConfig =
            with kernel.lib.config;
            (kernel.lib.utils.concat-config [
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

        generated = kernel.lib.kernel-gen {
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
        pizero-kernelPackages = generated.packages;
        pizero-kernel = generated.kernel;
      };
  };
}

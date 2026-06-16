{ kernel, ... }:
{
  kernel.main = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.main.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        isClang = true;
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.utils.calc-version {
          inherit src;
          stdenv = pkgs.stdenvNoCC.mkDerivation;
        };
        tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
        patches =
          (kernel.patches.cachyos {
            inherit pkgs;
            majorMinor = version.majorMinor;
          }).common
          ++ tachyonPatches.common
          ++ tachyonPatches.notGaming;

        main-config = kernel.lib.config-gen {
          inherit
            isClang
            patches
            pkgs
            src
            ;
          config = kernel.lib.kConfig { inherit pkgs; };
          denialConfig = kernel.lib.denial.all;
          structConfig =
            with kernel.lib.config;
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
  };
}

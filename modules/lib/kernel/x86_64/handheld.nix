{ kernel, ... }:
{
  kernel.handheld = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.handheld.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        isClang = true;
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.utils.calc-version {
          inherit src;
          stdenv = pkgs.stdenvNoCC.mkDerivation;
        };
        cachyosPatches = kernel.patches.cachyos {
          inherit pkgs;
          majorMinor = version.majorMinor;
        };
        tachyonPatches = (kernel.patches.tachyon { inherit pkgs; });
        patches =
          cachyosPatches.common
          ++ cachyosPatches.handheld
          ++ tachyonPatches.common
          ++ tachyonPatches.gaming
          ++ (kernel.patches.asus { inherit pkgs; });

        handheld-config = kernel.lib.config-gen {
          inherit
            isClang
            patches
            pkgs
            src
            ;
          config = kernel.lib.std-config { inherit pkgs; };
          denialConfig = kernel.lib.denial.all;
          structConfig =
            with kernel.lib.config;
            (kernel.lib.utils.concat-config [
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

        generated = kernel.lib.kernel-gen {
          localVer = "-handheld-native";
          configfile = handheld-config;
          version = version.string;
          inherit
            pkgs
            src
            isClang
            patches
            ;
        };
      in
      {
        inherit handheld-config;
        handheld-kernelPackages = generated.packages;
        handheld-kernel = generated.kernel;
      };
  };
}

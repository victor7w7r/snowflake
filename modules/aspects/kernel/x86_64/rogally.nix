{ kernel, lib, ... }:
{
  kernel.rogally = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.rogally.result { pkgs = prev; }) ];
    result =
      { pkgs }:
      let
        isClang = true;
        src = (kernel.lib.linux { inherit pkgs; });
        version = kernel.lib.version {
          inherit src;
          stdenv = pkgs.stdenvNoCC;
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

        handheld-config = kernel.lib.config-generator {
          inherit
            isClang
            patches
            pkgs
            src
            ;
          config = (kernel.lib.config { inherit pkgs; });
          structConfig =
            with kernel.config;
            lib.mkMerge [
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
            ];
        };

        kernel-gen = kernel.lib.kernel-generator {
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
        handheld-kernelPackages = kernel-gen.packages;
        handheld-kernel = kernel-gen.kernel;
      };
  };
}

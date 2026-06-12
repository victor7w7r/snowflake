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
          config = kernel.lib.std-config { inherit pkgs; };
          structConfig =
            kernel.lib.config.amd
            // kernel.lib.config.blacklist.all
            // kernel.lib.config.fs.bcachefs
            // kernel.lib.config.fs.overlayfs
            // kernel.lib.config.fs.xfs
            // kernel.lib.config.general
            // kernel.lib.config.highfreq
            // kernel.lib.config.net
            // kernel.lib.config.zram
            // kernel.lib.config.all-debug
            // kernel.lib.config.all-vendor
            // (kernel.lib.config.cmdline { isAmd = true; });
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

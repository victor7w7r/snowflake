{ kernel, ... }:
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
          config = kernel.lib.std.std-config { inherit pkgs; };

          miscDenialConfig = with kernel.lib.denial; (kernel.lib.functors.app-config [ sensors.all ]);
          denialConfig =
            with kernel.lib.denial;
            (kernel.lib.functors.app-config [
              crypto.all
              dev.all
              filesystems.all
              fuel.all
              general.all
              gpio
              hardware.all
              input.all
              mfd
              net.all
              sound
              serial.all
              storage.all
              usb.all
              vendor
              wmi
            ]);

          structConfig =
            with kernel.lib.config;
            (kernel.lib.functors.app-config [
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

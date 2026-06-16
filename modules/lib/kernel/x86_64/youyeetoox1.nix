{ kernel, ... }:
{
  kernel.server = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.server.result { pkgs = prev; }) ];
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
          cachyosPatches.optimization
          ++ cachyosPatches.hardened
          ++ cachyosPatches.governors
          ++ tachyonPatches.common
          ++ tachyonPatches.notGaming;

        server-config = kernel.lib.config-gen {
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
              blacklist.all
              fs.bcachefs
              fs.overlayfs
              fs.xfs
              general
              lowfreq
              net
              storage.all
              all-debug
              all-vendor
              (cmdline {
                isIntel = true;
                isSata = true;
                isSec = true;
              })
            ]);
        };

        generated = kernel.lib.kernel-gen {
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
      in
      {
        inherit server-config;
        server-kernelPackages = generated.packages;
        server-kernel = generated.kernel;
      };
  };
}

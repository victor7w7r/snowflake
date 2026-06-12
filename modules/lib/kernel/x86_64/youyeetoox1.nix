{ kernel, ... }:
{
  kernel.youyeetoox1 = {
    nixos.nixpkgs.overlays = [ (_: prev: kernel.youyeetoox1.result { pkgs = prev; }) ];
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
          cachyosPatches.optimization
          ++ cachyosPatches.hardened
          ++ cachyosPatches.governors
          ++ tachyonPatches.common
          ++ tachyonPatches.notGaming;

        server-config = kernel.lib.config-generator {
          inherit
            isClang
            patches
            pkgs
            src
            ;
          config = kernel.lib.std-config { inherit pkgs; };
          structConfig =
            kernel.lib.config.intel
            // kernel.lib.config.blacklist.all
            // kernel.lib.config.fs.bcachefs
            // kernel.lib.config.fs.overlayfs
            // kernel.lib.config.fs.xfs
            // kernel.lib.config.general
            // kernel.lib.config.lowfreq
            // kernel.lib.config.net
            // kernel.lib.config.storage.all
            // kernel.lib.config.all-debug
            // kernel.lib.config.all-vendor
            // (kernel.lib.config.cmdline {
              isIntel = true;
              isSata = true;
              isSec = true;
            });
        };

        kernel-gen = kernel.lib.kernel-generator {
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
        server-kernelPackages = kernel-gen.packages;
        server-kernel = kernel-gen.kernel;
      };
  };
}

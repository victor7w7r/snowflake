{ inputs, kernel, ... }:
{
  imports = [ (inputs.den.namespace "kernel" true) ];

  kernel = {
    handheld.nixos.nixpkgs.overlays = [ (_: prev: kernel.hosts.handheld prev) ];
    main.nixos.nixpkgs.overlays = [ (_: prev: kernel.hosts.main prev) ];
    server.nixos.nixpkgs.overlays = [ (_: prev: kernel.hosts.server prev) ];
    pizero.nixos.nixpkgs.overlays = [ (_: prev: kernel.hosts.pizero prev) ];

    lib = {
      injector = pkgs: {
        gen-config = configContent: kernel.lib.gen-config pkgs configContent;
        calc-version = src: kernel.lib.calc-version pkgs src;
        config-gen =
          {
            isArm ? true,
            isClang ? true,
            disableDenial ? false,
            structConfig,
            config,
            patches,
            src,
          }:
          kernel.lib.config-gen {
            inherit
              isArm
              isClang
              structConfig
              config
              disableDenial
              patches
              pkgs
              src
              ;
          };
        kernel-gen =
          {
            localVer,
            configfile,
            patches,
            isClang ? true,
            src,
            version,
          }:
          kernel.lib.kernel-gen {
            inherit
              localVer
              configfile
              patches
              pkgs
              isClang
              src
              version
              ;
          };
      };
      params.values = {
        isClang = false;
        isArm = false;
        localVer = "";
        hardened = false;
      };
    };
  };
}

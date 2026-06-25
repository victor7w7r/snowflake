{ inputs, kernel, ... }:
{
  imports = [ (inputs.den.namespace "kernel" true) ];

  kernel = {
    handheld.nixos.nixpkgs.overlays = [
      (final: _: kernel.hosts.handheld final)
      (final: _: builtins.trace (kernel.hosts.test.attrTest final) (kernel.hosts.test.attrTest final))
    ];
    hosts.test.attrTest =
      final:
      final.writeShellApplication {
        name = "hola-test";
        text = ''
          echo "¡La configuración de overlays está andando, ctm!"
          echo "Kernel actual: $(uname -r)"
        '';
      };

    main.nixos.nixpkgs.overlays = [ (final: _: kernel.hosts.main final) ];
    server.nixos.nixpkgs.overlays = [ (final: _: kernel.hosts.server final) ];
    pizero.nixos.nixpkgs.overlays = [ (final: _: kernel.hosts.pizero final) ];
    superlab.nixos.nixpkgs.overlays = [ (final: _: kernel.hosts.superlab final) ];
    lib.injector = pkgs: {
      calc-version = src: kernel.lib.calc-version pkgs src;
      config-gen =
        {
          isArm ? false,
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
          isArm ? false,
          src,
          version,
        }:
        kernel.lib.kernel-gen {
          inherit
            localVer
            configfile
            patches
            pkgs
            isArm
            isClang
            src
            version
            ;
        };
    };
  };
}

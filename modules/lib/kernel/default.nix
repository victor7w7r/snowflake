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
        config-gen = kernel.lib.config-gen pkgs;
        kernel-gen = kernel.lib.kernel-gen pkgs;
        gen-config = kernel.lib.gen-config pkgs;
        calc-version = kernel.lib.calc-version pkgs;
      };
      params = {
        isClang = false;
        isArm = false;
        localVer = "";
      };
    };
  };
}

{ kernel, ... }:
{
  kernel.linux.injector = pkgs: {
    cachyos = kernel.linux.cachyos pkgs;
    kConfig = hardened: kernel.linux.kConfig hardened pkgs;
  };
}

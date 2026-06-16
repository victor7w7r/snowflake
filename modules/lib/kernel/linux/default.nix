{ kernel, ... }:
{
  kernel.linux.injector = pkgs: {
    cachyos = kernel.linux.cachyos pkgs;
    kConfig = kernel.linux.kConfig pkgs;
  };
}

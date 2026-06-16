{ kernel, ... }:
{
  kernel.patches.injector = pkgs: {
    asus = kernel.patches.asus pkgs;
    bunker = kernel.patches.bunker pkgs;
    cachyos = kernel.patches.cachyos pkgs;
    sunxi = kernel.patches.sunxi pkgs;
    sunxi-wifi = kernel.patches.sunxi-wifi pkgs;
    tachyon = kernel.patches.tachyon pkgs;
  };
}

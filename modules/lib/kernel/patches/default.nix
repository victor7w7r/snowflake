{ kernel, ... }:
{
  kernel.patches.injector = pkgs: {
    asus = kernel.patches.asus pkgs;
    bunker = kernel.patches.bunker pkgs;
    cachyos = majorMinor: kernel.patches.cachyos pkgs majorMinor;
    sunxi = kernel.patches.sunxi pkgs;
    sunxi-wifi = kernel.patches.sunxi-wifi pkgs;
    tachyon = kernel.patches.tachyon pkgs;
  };
}

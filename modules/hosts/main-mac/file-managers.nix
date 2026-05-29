{ pkgs, ... }:
{
  main-mac.file-managers.nixos.system = {
    environment.defaultPackages = with pkgs; [
      clifm
      lf
      joshuto
      superfile
      termscp
      timg
      walk
    ];
  };
}

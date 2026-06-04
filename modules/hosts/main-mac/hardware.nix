{
  main-mac.hardware.nixos =
    { pkgs, ... }:
    {
      environment.defaultPackages = with pkgs; [
        cpufetch
        cyme
        macchina
        m-cli
        onefetch
        pfetch-rs
        smartmontools
        testdisk
      ];
    };
}

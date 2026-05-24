{
  den.aspects.base.provides.file-manager.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        superfile
        termscp
        tran
        trash-cli
        walk
        #tuifimanager
        #https://codeberg.org/sylphenix/sff
        #(pkgs.callPackage ./custom/fman.nix { })
      ];
    };
}

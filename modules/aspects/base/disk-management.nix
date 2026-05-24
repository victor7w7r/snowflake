{
  den.aspects.base.provides.disk-management.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        #(pkgs.callPackage ./custom/diskonaut.nix { })
        ddrescue
        ddrutility
        dust
        duff
        dua
        gdu
        fclones
        fdupes
        mmv-go
        ncdu
        rdfind
        parted
        rnr
        testdisk
        tparted
      ];
    };
}

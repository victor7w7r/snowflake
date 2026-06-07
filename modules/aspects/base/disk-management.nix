{
  den.aspects.base.disk-management.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        #(pkgs.callPackage ./custom/diskonaut.nix { })
        #https://aur.archlinux.org/packages/chkufsd-bin
        #https://github.com/benapetr/compress
        #https://github.com/gdelugre/ext4-crypt
        #https://aur.archlinux.org/packages/ntfs3-dkms-git
        #https://aur.archlinux.org/packages/udefrag
        #https://github.com/ximion/btrfsd
        compsize
        dust
        duf
        duff
        dua
        dysk
        httm
        gpart
        gdu
        fclones
        fdupes
        mmv-go
        ncdu
        rdfind
        partclone
        parted
        rnr
        smartmontools
        testdisk
        tparted
        wiper
        wipefreespace
      ];
    };
}

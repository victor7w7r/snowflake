{
  den.aspects.base.disk-management = {
    os =
      { pkgs, self', ... }:
      {
        environment.systemPackages = with pkgs; [
          self'.packages.diskonaut
          dua
          duf
          duff
          dust
          dysk
          fclones
          fdupes
          gdu
          mmv-go
          ncdu
          rdfind
          rnr
          smartmontools
          testdisk
          wiper
        ];
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          #https://aur.archlinux.org/packages/chkufsd-bin
          #https://github.com/benapetr/compress
          #https://github.com/gdelugre/ext4-crypt
          #https://aur.archlinux.org/packages/ntfs3-dkms-git
          #https://aur.archlinux.org/packages/udefrag
          #https://github.com/ximion/btrfsd
          compsize
          httm
          gpart
          partclone
          parted
          tparted
          wipefreespace
        ];
      };
  };
}

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
      { pkgs, self', ... }:
      {
        environment.systemPackages = with pkgs; [
          self'.packages.chkufsd
          self'.packages.compress
          self'.packages.ext4-crypt
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

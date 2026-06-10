{
  den.aspects.forensics = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ddrescue
          foremost
          magicrescue
          myrescue
          scrounge-ntfs
          stress
        ];
      };

    nixos =
      { pkgs, self', ... }:
      {
        environment.systemPackages = with pkgs; [
          #https://aur.archlinux.org/packages/r-linux
          self'.packages.btrfs-data-recovery
          self'.packages.btrfs-du
          cshatag
          ddrutility
          ext4magic
          extundelete
          safecopy
        ];
      };
  };
}

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
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          #https://aur.archlinux.org/packages/r-linux
          btrfs-data-recovery
          btrfs-du
          cshatag
          ddrutility
          ext4magic
          extundelete
          safecopy
        ];
      };
  };
}

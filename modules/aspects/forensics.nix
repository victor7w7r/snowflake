{
  den.aspects.forensics.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        #https://aur.archlinux.org/packages/r-linux
        btrfs-data-recovery
        btrfs-du
        cshatag
        ddrescue
        ddrutility
        ext4magic
        extundelete
        foremost
        magicrescue
        myrescue
        safecopy
        scrounge-ntfs
        stress
      ];
    };
}

{
  den.aspects.forensics.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        #https://aur.archlinux.org/packages/r-linux
        #(pkgs.callPackage ./custom/btrfs-du.nix { })
        #(pkgs.callPackage ./custom/btrfs-data-recovery.nix { })
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

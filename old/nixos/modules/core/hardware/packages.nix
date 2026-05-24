{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      iio-sensor-proxy
      viddy

    ]
    ++ [
      gpart
      partclone
      wiper
      wipefreespace
      #https://aur.archlinux.org/packages/chkufsd-bin
      #https://github.com/benapetr/compress
      #https://github.com/gdelugre/ext4-crypt
      #https://aur.archlinux.org/packages/ntfs3-dkms-git
      #https://aur.archlinux.org/packages/udefrag
      compsize
      fsarchiver
      httm
      #https://github.com/ximion/btrfsd
    ]
    ++ [
      alsa-utils
      cshatag
      ext4magic
      extundelete
      foremost
      magicrescue
      myrescue
      safecopy
      scrounge-ntfs
      sof-firmware
      stress
      #https://aur.archlinux.org/packages/r-linux
      (pkgs.callPackage ./custom/btrfs-du.nix { })
      (pkgs.callPackage ./custom/btrfs-data-recovery.nix { })
    ]
    ++ [
      cpulimit
      cyme
      dippi
      dysk
      dmidecode
      edid-decode
      edid-generator
      fanctl
      fan2go
      hwinfo
      read-edid
      rwedid
      smartmontools
    ];

}

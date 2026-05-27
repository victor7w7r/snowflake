{
  den.aspects.base.provides.filesystems.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        go-mtpfs
        exfatprogs
        f2fs-tools
        mtools
        ntfs2btrfs
        simple-mtpfs
        sshfs
      ];
    };
}

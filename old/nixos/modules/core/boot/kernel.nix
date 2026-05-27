{
  system,
  ...
}:
let
  supportedFilesystems = [
    "btrfs"
    "ext4"
    "exfat"
    "f2fs"
    "ntfs"
    "xfs"
    "vfat"
  ];
in
{
  boot = {
    inherit supportedFilesystems;
    loader = {

    }
    // (
      if system == "x86_64-linux" then
        {

        }
      else
        { }
    );

    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
  }
  // (
    if system == "x86_64-linux" then
      {
        initrd = {
          availableKernelModules = [
            "autofs"
            "dm-thin-pool"
            "dm-snapshot"
            "tpm_tis"
            "tpm_crb"
          ];
          inherit supportedFilesystems;
          services.lvm.enable = true;
        };
      /*  kernelModules = [
          "tcp_bbr"
          "dm-thin-pool"
          "veth"
          "xt_comment"
          "xt_CHECKSUM"
          "xt_MASQUERADE"
          "vhost_vsock"
          "iptable_mangle"
        ];
        }*/
    else
      { }
  );

}

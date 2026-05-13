let
  lvs = {
    thinpool = {
      size = "3.5T";
      lvm_type = "thin-pool";
    };
    cloud = (import ../lib/xfs.nix) {
      name = "cloud";
      size = "3.5T";
      mountpoint = "/nix/persist/cloud";
      logdev = "/dev/mapper/cloudlogcrypt";
      isRaid = true;
      extraEntireDisk = {
        pool = "thinpool";
        lvm_type = "thinlv";
      };
    };
  };
in
{
  disko.devices = {
    disk.cloud = {
      type = "disk";
      device = "/dev/mapper/cloud";
      content = {
        vg = "vg0";
        type = "lvm_pv";
      };
    };

    lvm_vg.vg0 = {
      type = "lvm_vg";
      inherit lvs;
    };

    /*
      nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=2G" ];
      };
    */
  };
}

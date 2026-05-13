let
  lvs = {
    thinpool = {
      size = "3.5G";
      lvm_type = "thin-pool";
    };
    persist = (import ../lib/xfs.nix) {
      name = "persist";
      size = "100%";
      mountpoint = "/nix/persist/cloud";
      logdev = "/dev/mapper/cloudlogcrypt";
      isRaid = true;
    };
  };
in
{
  disko.devices = {
    disk.bcache0 = {
      type = "disk";
      name = "bcache0";
      device = "/dev/bcache0";
      content = {
        vg = "vg0";
        type = "lvm_pv";
      };
    };

    lvm_vg.vg0 = {
      type = "lvm_vg";
      inherit lvs;
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "size=2G" ];
    };
  };
}

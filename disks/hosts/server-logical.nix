let
  lvs = {
    thinpool = {
      size = "3.5T";
      lvm_type = "thin-pool";
    };
    cloud = (import ../lib/xfs.nix) {
      name = "cloud";
      size = "3T";
      mountpoint = "/nix/persist/cloud";
      logdev = "/dev/mapper/cloudlogcrypt";
      isRaid = true;
      extraEntireDisk = {
        pool = "thinpool";
        lvm_type = "thinlv";
      };
    };
  };
  partlabel = "/dev/disk/by-partlabel";
in
{
  disko.devices = {
    disk = {
      bcache = {
        type = "disk";
        device = "/dev/bcache0";
        content = (import ../lib/luks.nix) {
          entireDisk = true;
          allowDiscards = false;
          name = "cloud";
          size = "100%";
          device = "/dev/bcache0";
          postMount = ''
            cryptsetup open ${partlabel}/disk-nvme-cloudcachecrypt cloudcachecrypt --key-file /tmp/key.txt || true
            cryptsetup open ${partlabel}/disk-nvme-cloudlogcrypt cloudlogcrypt --key-file /tmp/key.txt || true
          '';
        };
      };

      cloud = {
        type = "disk";
        device = "/dev/mapper/cloud";
        content = {
          vg = "vg0";
          type = "lvm_pv";
        };
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

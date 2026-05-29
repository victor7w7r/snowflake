{ den, inputs, ... }:
{
  server.disks-logical.nixos =
    { ... }:
    let
      partlabel = "/dev/disk/by-partlabel";
      lvs = {
        thinpool = {
          size = "100%";
          lvm_type = "thin-pool";
        };
        cloud = den.aspects.xfs.call {
          size = "3T";
          mountpoint = "/nix/persist/cloud";
          logdev = "/dev/mapper/cloudlogcrypt";
          isRaid = true;
          nameLvm = "cloud";
          extraSetupDisk = {
            pool = "thinpool";
            lvm_type = "thinlv";
          };
        };
      };
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];
      disko.devices = {
        disk = {
          bcache = {
            type = "disk";
            device = "/dev/bcache0";
            content = den.aspects.bcachefs.call {
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
              type = "lvm_pv";
              vg = "vg0";
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
    };
}

{
  handheld.initrd.nixos =
    { pkgs, ... }:
    {
      initrd.systemd.services.zram-format = {
        wantedBy = [ "initrd.target" ];
        requiredBy = [ "sysroot.mount" ];
        before = [
          "dev-mapper-persist.device"
          "dev-mapper-storage.device"
          "initrd-fs.target"
          "sysroot.mount"
        ];
        after = [ "systemd-modules-load.service" ];
        unitConfig.DefaultDependencies = false;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        path = with pkgs; [
          coreutils
          e2fsprogs
          systemd
          util-linux
        ];
        script = ''
          set -e
          mkdir -p /media

          echo 4G > /sys/block/zram1/disksize
          mkfs.ext4 -m 0 -O "^has_journal,^huge_file,^flex_bg" /dev/zram1
        '';
      };
    };
}

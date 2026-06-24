{
  server.systemd.nixos.systemd = {
    tmpfiles.rules = [ "w /sys/block/bcache0/bcache/cache_mode - - - - writethrough" ];
    services.lvm-snapshot-weekly = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          /run/current-system/sw/bin/lvcreate \
            --snapshot --name "snapshot-cloud-$(date +%Y-%m-%d)" \
            vg0/cloud
        '';
      };
    };
    timers.lvm-snapshot-weekly = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        Unit = "lvm-snapshot-weekly.service";
      };
    };
  };
}

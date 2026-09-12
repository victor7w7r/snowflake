{
  den.aspects.phone.services.rmtfs.nixos = { pkgs, ... }: {
    systemd.services.rmtfs = {
      description = "Qualcomm Remote Filesystem Daemon (rmtfs)";
      wantedBy = [ "multi-user.target" ];
      before = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.rmtfs}/bin/rmtfs -r -P -s";
        Restart = "on-failure";
        RestartSec = "2s";
        User = "root";
        Group = "root";
      };
    };
  };
}

{
  den.aspects.phone.services.rmtfs.nixos =
    { pkgs, ... }:
    pkgs.rmtfs
    |> (rmtfs: {
      environment.systemPackages = [ rmtfs ];

      systemd.services.rmtfs = {
        description = "Qualcomm Remote Filesystem Daemon (rmtfs)";
        wantedBy = [ "multi-user.target" ];
        before = [ "network.target" ];

        serviceConfig = {
          ExecStart = "${rmtfs}/bin/rmtfs -r -P -s";
          Restart = "on-failure";
          RestartSec = "2s";
          User = "root";
          Group = "root";
        };
      };
    });
}

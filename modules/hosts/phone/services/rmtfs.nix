{
  den.aspects.phone.services.rmtfs.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ rmtfs ];

      systemd.services.rmtfs = {
        description = "Qualcomm Remote Filesystem Daemon (rmtfs)";
        wantedBy = [ "multi-user.target" ];
        requires = [ "qrtr-ns.service" ];
        after = [ "qrtr-ns.service" ];
        serviceConfig = {
          ExecStart = "${pkgs.rmtfs}/bin/rmtfs -r -P -s";
          Restart = "always";
          RestartSec = "2s";
        };
      };
    };
}

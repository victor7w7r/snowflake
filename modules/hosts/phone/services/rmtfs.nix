{
  den.aspects.phone.services.rmtfs.nixos =
    { pkgs, ... }:
    pkgs.rmtfs
    |> (rmtfs: {
      environment.systemPackages = [ rmtfs ];

      systemd.services.rmtfs = {
        description = "Qualcomm Remote Filesystem Daemon (rmtfs)";
        wantedBy = [ "multi-user.target" ];
        before = [
          "network.target"
          "NetworkManager.service"
          "ModemManager.service"
          "tqftpserv.service"
        ];
        requires = [
          "qrtr-ns.service"
          "pd-mapper.service"
          "dev-qcom_rmtfs_mem1.device"
        ];
        after = [
          "qrtr-ns.service"
          "pd-mapper.service"
          "dev-qcom_rmtfs_mem1.device"
        ];
        unitConfig.ConditionPathExists = "/dev/qcom_rmtfs_mem1";

        serviceConfig = {
          ExecStart = "${rmtfs}/bin/rmtfs -r -P -s";
          Restart = "always";
          RestartSec = "1s";
          User = "root";
          Group = "root";
        };
      };
    });
}

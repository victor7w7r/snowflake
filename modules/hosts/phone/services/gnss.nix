{
  den.aspects.phone.services.gnss.nixos = { pkgs, ... }: {
    systemd.services.gnss = {
      description = "Qualcomm GNSS Modem Setup";
      wantedBy = [ "default.target" ];
      after = [ "ModemManager.service" ];
      requires = [ "ModemManager.service" ];
      startLimitIntervalSec = 300;
      startLimitBurst = 10;
      serviceConfig = {
        Type = "oneshot";
        ExecStart =
          "${pkgs.libqmi}/bin/qmicli  -d qrtr://0"
          |> (qmicli: [
            "${qmicli} --loc-set-engine-lock=mt"
            "${qmicli} --loc-set-nmea-types=all"
          ]);
        Restart = "on-failure";
        RestartSec = 30;
      };
    };
  };
}

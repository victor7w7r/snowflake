{ inputs, ... }: {
  den.aspects.phone.services.tqftpserv.nixos = { pkgs, ... }: {
    systemd.services.tqftpserv = {
      description = "Qualcomm QRTR TFTP services (tqftpserv)";
      wantedBy = [ "multi-user.target" ];
      before = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${
          pkgs.tqftpserv.overrideAttrs (_: {
            src = inputs.tqftpserv;
          })
        }/bin/tqftpserv -v";
        Restart = "on-failure";
        RestartSec = "2s";
        User = "root";
        Group = "root";
      };
    };
  };
}

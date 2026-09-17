{ inputs, ... }: {
  den.aspects.phone.services.tqftpserv.nixos = { pkgs, ... }: {
    systemd.services = {
      tqftpserv = {
        description = "Qualcomm QRTR TFTP services (tqftpserv)";
        wantedBy = [ "multi-user.target" ];
        requires = [
          "qrtr-ns.service"
          "pd-mapper.service"
          "tqftpserv-populate-data.service"
        ];
        after = [
          "qrtr-ns.service"
          "pd-mapper.service"
          "tqftpserv-populate-data.service"
        ];
        before = [
          "network.target"
          "NetworkManager.service"
          "ModemManager.service"
        ];
        serviceConfig = {
          ExecStart = "${
            pkgs.tqftpserv.overrideAttrs (_: {
              src = inputs.tqftpserv;
            })
          }/bin/tqftpserv";
          Restart = "always";
          RestartSec = "1s";
          User = "root";
          Group = "root";
        };
      };

      tqftpserv-populate-data = {
        description = "Data filling for tqftpserv";
        requires = [ "mnt-vendor-persist\x2dro.mount" ];
        after = [ "mnt-vendor-persist\x2dro.mount" ];
        before = [ "tqftpserv.service" ];
        wantedBy = [ "multi-user.target" ];

        path = with pkgs; [ coreutils ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        script = ''
          set -eu

          PERSIST_SRC="/mnt/vendor/persist-ro/rfs/msm/mpss"
          TQFTPSERV_TMP="/var/lib/tqftpserv"

          if [ -f "$TQFTPSERV_TMP/readwrite_ready" ]; then
            exit 0
          fi

          mkdir -p "$TQFTPSERV_TMP"

          if [ -d "$PERSIST_SRC" ]; then
            cp -a "$PERSIST_SRC/." "$TQFTPSERV_TMP/"
            touch "$TQFTPSERV_TMP/readwrite_ready"
          else
            echo "Error: $PERSIST_SRC does not exist" >&2
            exit 1
          fi
        '';
      };
    };
  };
}

{ inputs, ... }: {
  den.aspects.phone.services.hexagonrpc.nixos =
    { lib, pkgs, ... }:
    (
      {
        class ? "sdsp",
        description ? "SDSP",
        command ? "-d sdsp -s",
        route ? "${inputs.oneplus}/usr/share/qcom/sdm845/OnePlus/oneplus6/",
      }:
      {
        description = "Hexagonrpcd ${description}";
        wantedBy = [ "multi-user.target" ];
        before = [ "suspend.target" ];
        conflicts = [ "suspend.target" ];
        after = [
          "network.target"
          "qrtr-ns.service"
          "pd-mapper.service"
          "rmtfs.service"
          "tqftpserv.service"
          "hexagonrpcd-populate-data.service"
          "dev-fastrpc-${class}.device"
        ];
        requires = [
          "qrtr-ns.service"
          "pd-mapper.service"
          "rmtfs.service"
          "tqftpserv.service"
          "hexagonrpcd-populate-data.service"
          "dev-fastrpc-${class}.device"
        ];

        serviceConfig = {
          ExecStart = "${pkgs.writeShellScript "start-hexagonrpcd-${class}-${description}" ''
            exec ${pkgs.hexagonrpc}/bin/hexagonrpcd -f /dev/fastrpc-${class} \
              ${command} -R ${route}
          ''}";
          Restart = "always";
          RestartSec = 3;
          User = "fastrpc";
          Group = "fastrpc";
        };
      }
    )
    |> (service-gen: {
      environment.pathsToLink = [ "/share/qcom" ];

      users = {
        groups.fastrpc = { };
        users.fastrpc = {
          isSystemUser = true;
          group = "fastrpc";
        };
      };

      services.udev.extraRules = lib.mkBefore ''
        SUBSYSTEM=="misc", KERNEL=="fastrpc-*", OWNER="fastrpc", GROUP="fastrpc", MODE="0600", TAG+="systemd"
        SUBSYSTEM=="misc", KERNEL=="fastrpc-adsp*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity"
        SUBSYSTEM=="misc", KERNEL=="fastrpc-sdsp*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity ssc-light ssc-compass"
      '';

      systemd.services = {
        hexagonrpcd-adsp-sdsp = service-gen { };
        hexagonrpcd-adsp-rootpd = service-gen {
          class = "adsp";
          description = "ADSP RootPD";
          command = "-d adsp";
        };

        hexagonrpcd-adsp-sensorpd = service-gen {
          class = "adsp";
          description = "ADSP SensorPD";
          command = "-d adsp -s";
        };

        hexagonrpcd-populate-data = {
          description = "Populate writable /mnt/vendor/persist tmpfs from persist-ro";
          requires = [
            "mnt-vendor-persist\x2dro.mount"
            "mnt-vendor-persist.mount"
          ];
          after = [
            "mnt-vendor-persist\x2dro.mount"
            "mnt-vendor-persist.mount"
          ];
          before = [
            "hexagonrpcd-adsp-sdsp.service"
            "hexagonrpcd-adsp-rootpd.service"
            "hexagonrpcd-adsp-sensorpd.service"
          ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };

          script = ''
            set -eu

            source=/mnt/vendor/persist-ro/sensors
            destination=/mnt/vendor/persist/sensors
            mkdir -p "$destination"

            if [ -d "$source" ]; then
              cp -a "$source/." "$destination/"
            fi

            chown -R fastrpc:fastrpc "$destination" || true
          '';
        };
      };
    });
}

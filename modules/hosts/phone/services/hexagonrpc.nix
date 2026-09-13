{ inputs, ... }: {
  den.aspects.phone.services.hexagonrpc.nixos =
    { pkgs, ... }:
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
        after = [ "network.target" ];

        unitConfig.ConditionPathExists = "/dev/fastrpc-${class}";

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
      users = {
        groups.fastrpc = { };
        users.fastrpc = {
          isSystemUser = true;
          group = "fastrpc";
        };
      };

      services.udev.extraRules = ''SUBSYSTEM=="misc", KERNEL=="fastrpc-*", OWNER="fastrpc", GROUP="fastrpc", MODE="0600"'';

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

        populate-persist-tmpfs = {
          description = "Populate writable /mnt/vendor/persist tmpfs from persist-ro";
          after = [
            "mnt-vendor-persist-ro.mount"
            "mnt-vendor-persist.mount"
          ];
          wantedBy = [ "multi-user.target" ];

          unitConfig.ConditionPathExists = "/dev/disk/by-partlabel/persist";

          serviceConfig = {
            Type = "oneshot";
            ExecStart = pkgs.writeShellScript "populate-persist" ''
              set -e
              if [ -d /mnt/vendor/persist-ro/sensors ]; then
                cp -a /mnt/vendor/persist-ro/* /mnt/vendor/persist/
                chown -R fastrpc:fastrpc /mnt/vendor/persist/sensors || true
              fi
            '';
          };
        };
      };
    });
}

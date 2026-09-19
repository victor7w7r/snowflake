{ inputs, ... }: {
  den.aspects.phone.services.hexagonrpc.nixos =
    { pkgs, self', ... }:
    (
      {
        class ? "sdsp",
        description ? "SDSP",
        command ? "-d sdsp -s",
        route ? "${inputs.oneplus}/usr/share/qcom/sdm845/OnePlus/oneplus6",
      }:
      {
        description = "Hexagonrpcd ${description}";
        wantedBy = [ "multi-user.target" ];
        after = [ "hexagonrpcd-populate-data.service" ];
        requires = [ "hexagonrpcd-populate-data.service" ];

        serviceConfig = {
          ExecStart = [
            ""
            "${self'.packages.hexagonrpc}/bin/hexagonrpcd -f /dev/fastrpc-sdsp -d sdsp -s -R /nix/persist/vendor/persist/serve"
          ];
          TimeoutStopSec = 10;
        };
      }
    )
    |> (service-gen: {

      systemd.services = {

        /*
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
        */

        hexagonrpcd-sdsp = service-gen { };

        iio-sensor-proxy = {
          after = [ "hexagonrpcd-sdsp.service" ];
          wants = [ "hexagonrpcd-sdsp.service" ];
          unitConfig.StartLimitIntervalSec = 0;
          serviceConfig = {
            Restart = "always";
            RestartSec = 30;
          };
        };

        hexagonrpcd-populate-data = {
          description = "Populate writable /mnt/vendor/persist tmpfs from persist-ro";
          after = [ "mnt-vendor-persist.mount" ];
          requires = [ "mnt-vendor-persist.mount" ];
          before = [ "hexagonrpcd-sdsp.service" ];
          requiredBy = [ "hexagonrpcd-sdsp.service" ];
          unitConfig.ConditionPathExists = "/mnt/vendor/persist/sensors/registry/registry";
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = pkgs.writeShellScript "hexagonrpcd-populate-data" ''
              set -eu
              src=${inputs.oneplus}/share/qcom/sdm845/OnePlus/oneplus6
              dst=/nix/persist/vendor/persist/serve
              rm -rf "$dst"
              mkdir -p "$dst/sensors"
              ln -s "$src/dsp" "$dst/dsp"
              ln -s "$src/sensors/config" "$dst/sensors/config"
              [ -e "$src/sensors/sns_reg.conf" ] && ln -s "$src/sensors/sns_reg.conf" "$dst/sensors/sns_reg.conf" || true
              cp -aL /mnt/vendor/persist/sensors/registry/registry "$dst/sensors/registry"
              chown -R fastrpc:fastrpc /nix/persist/vendor
              chmod -R u+rwX "$dst/sensors/registry"
            '';
          };
        };
      };
    });
}

{
  den.aspects.phone.services.iio-sensor-proxy.nixos = { self', ... }: {
    hardware.sensor.iio = {
      enable = true;
      package = self'.packages.iio-sensor-proxy;
    };

    systemd.services.iio-sensor-proxy = {
      requires = [ "hexagonrpcd-sdsp.service" ];
      after = [ "hexagonrpcd-sdsp.service" ];
      overrideStrategy = "asDropin";
      serviceConfig = {
        Restart = "always";
        RestartSec = "5s";
        RestrictAddressFamilies = [
          "AF_QIPCRTR"
          "AF_LOCAL"
        ];
      };
    };
  };
}

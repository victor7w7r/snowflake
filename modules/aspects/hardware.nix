{ lib, ... }:
{
  den.aspects.hardware = {
    nixos =
      {
        isMain,
        isHandheld,
        pkgs,
        ...
      }:
      {
        environment.systemPackages =
          with pkgs;
          [
            cpulimit
            cyme
            dippi
            dmidecode
            edid-decode
            edid-generator
            fanctl
            fan2go
            hwinfo
            i2c-tools
            iio-sensor-proxy
            lm_sensors
            lshw
            pciutils
            read-edid
            rwedid
            usbutils
          ]
          ++ lib.optionals (isMain || isHandheld) [
            bolt
            tbtools
            thunderbolt
            kdePackages.plasma-thunderbolt
          ];
        hardware = {
          sensor.iio.enable = true;
          ksm.enable = true;
          #sensor.hddtemp.enable = true; SPECIFICATE IN HOSTS with .drives
        };
        services = {
          power-profiles-daemon.enable = true;
          smartd.enable = false;
          hardware.bolt.enable = isMain || isHandheld;
        };
        programs = {
          corectrl.enable = true;
          #corefreq.enable = true;
          iotop.enable = true;
          usbtop.enable = true;
          #coolercontrol.enable = host != "v7w7r-youyeetoox1";
        };
      };
  };
}

{
  den.aspects.hardware = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
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
        ];
        hardware = {
          sensor.iio.enable = true;
          ksm.enable = true;
          #sensor.hddtemp.enable = true; SPECIFICATE IN HOSTS with .drives
        };
        services = {
          power-profiles-daemon.enable = true;
          smartd.enable = false;
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

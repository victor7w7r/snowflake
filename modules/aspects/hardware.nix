{ lib, ... }:
{
  den.aspects.hardware = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          cpulimit
          cyme
          edid-generator
          pciutils
          usbutils
        ];
      };
    nixos =
      {
        isGraphic,
        isIntel,
        isMain,
        isHandheld,
        isX86,
        pkgs,
        ...
      }:
      {
        environment.systemPackages =
          with pkgs;
          [
            dippi
            dmidecode
            edid-decode
            fanctl
            fan2go
            hwinfo
            i2c-tools
            iio-sensor-proxy
            lm_sensors
            lshw
            read-edid
            rwedid
          ]
          ++ lib.optionals (isMain || isHandheld) [
            bolt
            tbtools
            thunderbolt
            kdePackages.plasma-thunderbolt
          ];
        hardware = lib.mkMerge [
          (lib.mkIf isGraphic {
            graphics.enable = true;
          })
          /*
            (lib.mkIf (isGraphic && isX86) {
            graphics.enable32Bit = true;
            })
          */
          (lib.mkIf isIntel {
            cpu.intel.updateMicrocode = true;
          })
          {
            graphics.enable32Bit = lib.mkForce false;
            sensor.iio.enable = true;
            ksm.enable = true;
            #sensor.hddtemp.enable = true; SPECIFICATE IN HOSTS with .drives
          }
        ];
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

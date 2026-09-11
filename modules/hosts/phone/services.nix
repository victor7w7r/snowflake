{
  den.aspects.phone.services.nixos = { lib, ... }: {
    services = {
      fail2ban.enable = lib.mkForce false;
      bootmac = {
        enable = true;
        bluetooth.enable = true;
        wifi.enable = true;
      };
      buffyboard = {
        enable = false;
        settings.input.touchscreen = true;
      };
      logind.settings = {
        Login.HandlePowerKey = lib.mkDefault "ignore";
        Login.HandlePowerKeyLongPress = lib.mkDefault "poweroff";
      };

      pipewire.wireplumber.extraConfig = {
        "51-qcom"."monitor.alsa.rules" = [
          {
            matches = [
              { "node.name" = "~alsa_input.*"; }
              { "node.name" = "~alsa_output.*"; }
            ];

            actions.update-props = {
              "audio.format" = "S16LE";
              "audio.rate" = 48000;
              "api.alsa.period-size" = 4096;
              "api.alsa.period-num" = 6;
              "api.alsa.headroom" = 512;
            };
          }
        ];
      };

      q6voiced = {
        enable = true;
        settings = {
          q6voice_card = 0;
          q6voice_device = 6;
        };
      };
      getty.autologinUser = "victor7w7r";
      hexagonrpcd.sdsp.enable = true;
      msm-modem-uim-selection.enable = true;
      rmtfs.enable = true;
      swclock-offset.enable = true;
      tqftpserv.enable = true;
      upower.enable = true;

      udev.extraRules = ''
        ACTION=="remove", GOTO="iio_sensor_proxy_end"
        SUBSYSTEM=="misc", KERNEL=="fastrpc-adsp*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity"
        SUBSYSTEM=="misc", KERNEL=="fastrpc-sdsp*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity"
        LABEL="iio_sensor_proxy_end"
      '';
    };
  };
}

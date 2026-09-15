{
  den,
  hosts,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    disko-mobile = {
      url = "github:JuneStepp/disko/mobile";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mobile-nixos = {
      url = "github:mobile-nixos/mobile-nixos";
      flake = false;
    };
  };

  den.aspects.phone.common = {
    includes = with den.aspects; [
      (hosts.lib.zram {
        value = "8G";
        memoryPercent = 100;
      })
      audio._
      cli._
      dev.ccache
      #dev.zed
      dev.tools
      disks
      gui._
      misc.comm
      misc.fetch
      #zen._

      phone._
      phone.services._

      #android
      bluetooth
      emulation
      firewall
      games
      #kitty
      #libvirt
      plasma._
      remote
      root
      tools
      victor7w7r
      #virt
      #waydroid
    ];

    nixos =
      { lib, pkgs, ... }:
      {
        environment = {
          variables.GST_PLUGIN_FEATURE_RANK = "v4l2vp8dec:SECONDARY,v4l2vp8enc:NONE,v4l2vp9dec:SECONDARY,v4l2h264dec:SECONDARY,v4l2h264enc:NONE,v4l2h265dec:SECONDARY,v4l2h265enc:NONE,v4l2mpeg2dec:SECONDARY";
          persistence."/nix/persist" = {
            directories = lib.mkAfter [
              "/var/lib/ModemManager"
              "/var/lib/tqftpserv"
            ];
            users = {
              "victor7w7r".directories = [ ".cache" ];
              root.directories = [ ".cache" ];
            };
          };
          enableAllTerminfo = true;
        };

        nix.settings.max-jobs = lib.mkDefault 2;
        system.nixos.label = "";
        networking.firewall.trustedInterfaces = [ "usb0" ];

        hardware = {
          deviceTree.enable = true;
          sensor.iio.enable = true;
          firmware = lib.mkAfter [
            (pkgs.runCommand "oneplus-sdm845-firmware" { baseFw = inputs.oneplus; } ''
              mkdir -p $out/lib/firmware
              cp -r $baseFw/lib/firmware/* $out/lib/firmware/
              chmod +w -R $out
              rm -rf $out/lib/firmware/postmarketos
              cp -r $baseFw/lib/firmware/postmarketos/* $out/lib/firmware
              ls -lah $out/lib/firmware/qcom/sdm845
            '')
          ];
        };

        systemd.services = {
          iio-sensor-proxy.serviceConfig.TimeoutStopSec = 3;
          "sshd-inhibit-sleep@" = {
            description = "Inhibit sleep when sshd connection is active";

            wantedBy = [ "sshd@.service" ];
            bindsTo = [ "sshd@.service" ];

            serviceConfig.ExecStart = ''
              systemd-inhibit --what sleep \
                --who "sshd-inhibit-sleep@%i.service" \
                --why "SSH session active" \
                ${lib.getExe' pkgs.coreutils "sleep"} infinity
            '';
          };
        };

        services = {
          xserver.displayManager.lightdm.enable = false;
          displayManager.gdm.enable = false;
          fail2ban.enable = lib.mkForce false;
          logind.settings = {
            Login.HandlePowerKey = lib.mkDefault "ignore";
            Login.HandlePowerKeyLongPress = lib.mkDefault "poweroff";
          };

          getty.autologinUser = "victor7w7r";
          upower = {
            enable = true;
            percentageLow = lib.mkDefault 15;
            percentageCritical = lib.mkDefault 5;
            percentageAction = lib.mkDefault 3;
            criticalPowerAction = "PowerOff";
          };

          tlp.enable = lib.mkDefault true;
          udev.extraRules = builtins.concatStringsSep "\n" [
            ''ACTION=="remove", GOTO="iio_sensor_proxy_end"''
            ''SUBSYSTEM=="uio", ATTR{name}=="rmtfs", SYMLINK+="qcom_rmtfs_uio1"''
            ''SUBSYSTEM=="input", KERNEL=="event*", ENV{GM_WAKEUP_KEY_114}="0", ENV{GM_WAKEUP_KEY_115}="0"''
            ''LABEL="iio_sensor_proxy_end"''
          ];
        };
      };
  };
}

{ den, hosts, ... }:
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
      persistence
      plasma._
      remote
      root
      tools
      victor7w7r
      #virt
      #waydroid
    ];

    nixos =
      {
        lib,
        pkgs,
        self',
        ...
      }:
      {
        environment = {
          pathsToLink = [ "/share/qcom" ];
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
        networking = {
          networkmanager.wifi.powersave = true;
          firewall.trustedInterfaces = [
            "rndis0"
            "usb0"
          ];
        };

        users = {
          groups.fastrpc = { };
          users.fastrpc = {
            isSystemUser = true;
            group = "fastrpc";
          };
        };

        hardware = {
          deviceTree.enable = true;
          sensor.iio.enable = true;
          firmware = lib.mkAfter [ self'.packages.oneplus-firmware ];
        };

        systemd.services."sshd-inhibit-sleep@" = {
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

        services = {
          displayManager = {
            gdm.enable = false;
            sddm.enable = true;
            autoLogin = {
              enable = true;
              user = "victor7w7r";
            };
          };

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
          udev.extraRules = ''
            SUBSYSTEM=="input", KERNEL=="event*", ENV{GM_WAKEUP_KEY_114}="0", ENV{GM_WAKEUP_KEY_115}="0"
            SUBSYSTEM=="devfreq", KERNEL=="5000000.gpu", ATTR{min_freq}="675000000", ATTR{polling_interval}="16"
            SUBSYSTEM=="misc", KERNEL=="fastrpc-*", OWNER="fastrpc", GROUP="fastrpc", MODE="0600", TAG+="systemd"
            SUBSYSTEM=="input", KERNEL=="event*", ENV{ID_INPUT}=="1", SUBSYSTEMS=="input", ATTRS{name}=="pmi8998_haptics", TAG+="uaccess", ENV{FEEDBACKD_TYPE}="vibra"
            SUBSYSTEM=="uio", ATTR{name}=="rmtfs", SYMLINK+="qcom_rmtfs_uio1"
            SUBSYSTEM=="misc", KERNEL=="fastrpc-*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity"
            SUBSYSTEM=="misc", KERNEL=="fastrpc-*", ENV{ACCEL_MOUNT_MATRIX}+="-1, 0, 0; 0, 1, 0; 0, 0, -1"
          '';
        };
      };
  };
}

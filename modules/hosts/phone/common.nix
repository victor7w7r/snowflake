{
  den,
  hosts,
  inputs,
  tarball,
  ...
}:
{
  flake-file.inputs = {
    disko-mobile = {
      url = "github:JuneStepp/disko/mobile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.phone.common = {
    includes = with den.aspects; [
      (tarball.lib.call { })
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
            directories = lib.mkAfter [ "/var/lib/ModemManager" ];
            users = {
              "victor7w7r".directories = [ ".cache" ];
              root.directories = [ ".cache" ];
            };
          };
          enableAllTerminfo = true;
        };

        nix.settings.max-jobs = lib.mkDefault 2;
        nixpkgs.config.allowUnfreePackages = [ "oneplus-sdm845-firmware" ];
        powerManagement.cpuFreqGovernor = "schedutil";
        system.nixos.label = "";

        hardware = {
          deviceTree.enable = true;
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
            ''SUBSYSTEM=="misc", KERNEL=="fastrpc-*", ENV{ACCEL_MOUNT_MATRIX}+="-1, 0, 0; 0, 1, 0; 0, 0, -1"''
            ''SUBSYSTEM=="misc", KERNEL=="fastrpc-sdsp*", ENV{IIO_SENSOR_PROXY_TYPE}+="ssc-accel ssc-proximity ssc-light ssc-compass"''
            # prevent from getting woken up by volume up / down in Phosh / Gnome Mobile
            ''SUBSYSTEM=="input", KERNEL=="event*", ENV{GM_WAKEUP_KEY_114}="0", ENV{GM_WAKEUP_KEY_115}="0"''
            # hide android partitions
            ''SUBSYSTEM=="block", KERNEL=="sd[a-f][0-9]*", ENV{UDISKS_IGNORE}="1"''
          ];
        };
      };
  };
}

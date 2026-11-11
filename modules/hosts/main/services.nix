{
  den.aspects.main.services.nixos =
    { pkgs, self', ... }:
    {
      services = {
        fwupd.enable = true;
        udev.extraRules = ''
          SUBSYSTEM=="kvmfr", OWNER="libvirt-qemu", GROUP="libvirt-qemu", MODE="0660"
        '';
        cockpit.allowed-origins = [
          "https://192.168.100.6:9090"
          "http://192.168.100.6:9090"
          "https://100.64.0.2:9090"
          "http://100.64.0.2:9090"
        ];

        zfs = {
          autoScrub = {
            enable = true;
            interval = "Sat, 02:00";
            pools = [
              "zroot"
              "zssd"
              "zmini"
            ];
          };

          autoSnapshot = {
            enable = true;
            frequent = 4;
            hourly = 24;
            daily = 7;
            weekly = 4;
            monthly = 12;
            flags = "-k -p";
          };
          trim.enable = true;
          trim.interval = "weekly";
        };

        #thermald.enable = true;
      };
      systemd = {
        services = {
          t2fanrd = {
            enable = true;
            description = "T2FanRD daemon to manage fan curves for T2 Macs";
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
              Type = "exec";
              ExecStart = "${self'.packages.t2fanrd}/bin/t2fanrd";
              Restart = "always";
              PrivateTmp = true;
              ProtectSystem = true;
              ProtectHome = true;
              ProtectClock = true;
              ProtectHostname = true;
              ProtectControlGroups = true;
              ProtectKernelLogs = true;
              ProtectKernelModules = true;
              ProtectProc = "invisible";
              PrivateDevices = true;
              PrivateNetwork = true;
              NoNewPrivileges = true;
              DevicePolicy = "closed";
              KeyringMode = "private";
              LockPersonality = true;
              MemoryDenyWriteExecute = true;
              PrivateUsers = true;
              RemoveIPC = true;
              RestrictNamespaces = true;
              RestrictRealtime = true;
              RestrictSUIDSGID = true;
              SystemCallArchitectures = "native";
            };
          };
          apple-bce-reload = {
            enable = true;
            description = "Disable and Re-Enable Apple BCE Module";
            wantedBy = [ "sleep.target" ];
            before = [ "sleep.target" ];
            unitConfig.StopWhenUnneeded = true;

            serviceConfig = {
              User = "root";
              Type = "oneshot";
              RemainAfterExit = true;

              ExecStart = [
                "${pkgs.kmod}/bin/modprobe -r brcmfmac_wcc"
                "${pkgs.kmod}/bin/modprobe -r brcmfmac"
                "${pkgs.kmod}/bin/rmmod -f apple-bce"
              ];

              ExecStop = [
                "${pkgs.kmod}/bin/modprobe apple-bce"
                "${pkgs.kmod}/bin/modprobe brcmfmac"
                "${pkgs.kmod}/bin/modprobe brcmfmac_wcc"
              ];
            };
          };
        };
      };
    };
}

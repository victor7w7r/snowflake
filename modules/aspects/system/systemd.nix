{
  den.aspects.system.provides.systemd.nixos = {
    systemd = {
      enableEmergencyMode = true;
      network.wait-online.enable = false;
      settings.Manager = {
        DefaultTimeoutStartSec = "15s";
        DefaultTimeoutStopSec = "10s";
        DefaultTimeoutAbortSec = "5s";
        DefaultLimitNOFILE = "2048:2097152";
      };
    };

    services.journald.extraConfig = ''
      Storage=persistent
      Compress=yes
      MaxLevelStore=debug
      SystemMaxUse=500M
      RuntimeMaxUse=200M
      ForwardToConsole=yes
      MaxLevelConsole=debug
      TTYPath=/dev/ttyS0
    '';
  };
}

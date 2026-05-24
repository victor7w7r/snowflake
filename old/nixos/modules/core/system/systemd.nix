{ host, ... }:
{
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
}

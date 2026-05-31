{ den, ... }:
{
  den.aspects.tweaks = {
    includes = with den.aspects.tweaks._; [
      sysctl
      tmpfiles
      udev
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          fatrace
          kmon
          lazyjournal
          lnav
          pik
          s-tui
          systemctl-tui
          sysz
          watchexec
          zps
          #nvtopPackages.full
          #(pkgs.callPackage ./custom/journalview.nix { })
          #https://github.com/jasonwitty/socktop
          #https://github.com/XhuyZ/lazysys
          #pcp
          #uv pip install tiptop
        ];

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

  };
}

{ den, lib, ... }:
{
  den.policies.sysctl-to-boot =
    { host, ... }:
    [
      (den.lib.policy.route {
        fromClass = "sysctl";
        intoClass = host.class;
        path = [
          "boot"
          "kernel"
        ];
      })
    ];

  den.default.includes = [ den.policies.sysctl-to-boot ];

  den.aspects.tweaks.default = {
    nixos =
      {
        hasVisualKeyboard,
        isServer,
        isX86,
        pkgs,
        ...
      }:
      {
        environment = lib.mkMerge [
          (lib.mkIf isServer {
            etc."intel-undervolt.conf".text = "power package 8 28 10 2.4";
          })
          {
            systemPackages = with pkgs; [
              fatrace
              journalview
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
              #https://github.com/jasonwitty/socktop
              #https://github.com/XhuyZ/lazysys
              #pcp
              #uv pip install tiptop
            ];
          }
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

        services = {
          locate.enable = true;
          irqbalance.enable = hasVisualKeyboard;
          scx.enable = isX86;
          nohang = lib.optionalAttrs (!hasVisualKeyboard) {
            enable = true;
          };
          /*
            dbus = {
              packages = with pkgs; [
                nohang
                uresourced
              ];
            };
          */
          ananicy = lib.optionalAttrs hasVisualKeyboard {
            enable = true;
            package = pkgs.ananicy-cpp;
            rulesProvider = pkgs.ananicy-rules-cachyos;
            extraRules = [
              {
                "name" = "gamescope";
                "nice" = -20;
              }
            ];
          };
          journald.extraConfig = ''
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

  };
}

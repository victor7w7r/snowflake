{ lib, hosts, ... }:
{
  den.aspects = {
    network-manager-persist.nixos.environment.persistence."/nix/persist".directories = lib.mkAfter [
      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"
    ];
    network-manager = {
      nixos = {
        systemd.services.NetworkManager-wait-online.enable = false;
        networking = {
          modemmanager.enable = lib.mkForce false;
          dhcpcd = {
            enable = true;
            wait = "background";
          };

          networkmanager = {
            enable = true;
            #settings.main.rc-manager = "resolvconf";
            #wifi.powersave = false;
            insertNameservers = [
              "8.8.8.8"
              "8.8.4.4"
            ];
            dhcp = "dhcpcd";
          };

          nameservers = [
            "8.8.8.8"
            "8.8.4.4"
          ];

          /*
            resolvconf = {
            enable = true;
            useLocalResolver = true;
            dnsExtensionMechanism = false;
            extraConfig = ''
              local_nameservers=""
              name_server_blacklist="0.0.0.0 127.0.0.1"
              resolv_conf_local_only=NO
            '';
            };
          */
        };
      };
      provides = {
        "${hosts.server}".nixos.networking = {
          networkmanager.enable = false;
          resolvconf.enable = false;
          allowedTCPPorts = lib.mkAfter [ 8006 ];
        };
        "${hosts.phone}".nixos.networking.networkmanager.unmanaged = [
          "rndis0"
          "usb0"
        ];
      };
    };
  };
}

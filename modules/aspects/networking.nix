{ lib, hosts-attrs, ... }:
{
  den.aspects.networking = {
    nixos = {
      programs = {
        bandwhich.enable = true;
        trippy.enable = true;
      };

      networking = {
        #hostName = "${host}";
        hosts."64.16.239.70" = [ "us-central-1.telnyxstorage.com" ];
        timeServers = [
          "0.south-america.pool.ntp.org"
          "1.south-america.pool.ntp.org"
          "2.south-america.pool.ntp.org"
          "3.south-america.pool.ntp.org"
        ];

        firewall = {
          enable = true;
          allowPing = true;
          checkReversePath = false;
          logRefusedPackets = true;
          allowedTCPPorts = [
            22
            9090
          ];
        };

        modemmanager.enable = lib.mkForce false;
        networkmanager = {
          enable = true;
          settings.main.rc-manager = "resolvconf";
          wifi.powersave = false;
        };

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
      };
    };

    provides = {
      "${hosts-attrs.server}".nixos.networking = {
        networkmanager.enable = false;
        resolvconf.enable = false;
        allowedTCPPorts = lib.mkAfter [ 8006 ];
      };
      "${hosts-attrs.phone}".nixos.networking.networkmanager.unmanaged = [
        "rndis0"
        "usb0"
      ];
    };
  };
}

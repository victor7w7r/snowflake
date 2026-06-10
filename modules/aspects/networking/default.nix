{ lib, ... }:
{
  den.aspects.networking.default = {
    nixos =
      { isPersistent, isServer, ... }:
      {
        networking = {
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
            logRefusedConnections = false;
            logReversePathDrops = true;
            allowedTCPPorts = [
              22
              9090
            ]
            ++ lib.optionals isServer [ 8006 ];
          };
        };

        systemd.services.tailscaled = lib.optionalAttrs isPersistent {
          after = [ "network-online.target" ];
          wants = [ "network-online.target" ];
        };

        services = lib.optionalAttrs isPersistent {
          #aria2.enable = true; NEEDS KEY
          #openvpn.package = true;
          croc.enable = true;
          dnsmasq.enable = true;
          tailscale = {
            enable = true;
            openFirewall = true;
            useRoutingFeatures = "server";
            extraUpFlags = [
              "--advertise-exit-node"
              "--ssh"
              "--accept-dns=true"
              "--accept-routes"
            ];
          };
          ttyd = {
            enable = true;
            writeable = true;
          };
        };

        programs = lib.optionalAttrs isPersistent {
          bandwhich.enable = true;
          trippy.enable = true;
        };
        /*
          resolvconf = {
          enable = !isServer;
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
    homeManager =
      { isPersistent, ... }:
      lib.optionalAttrs isPersistent {
        programs.himalaya.enable = true;
        services.pbgopy.enable = true;
      };
  };
}

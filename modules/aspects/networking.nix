{
  den.aspects = {
    networking = {
      nixos = {
        networking = {
          hosts."64.16.239.70" = [ "us-central-1.telnyxstorage.com" ];
          timeServers = [
            "0.south-america.pool.ntp.org"
            "1.south-america.pool.ntp.org"
            "2.south-america.pool.ntp.org"
            "3.south-america.pool.ntp.org"
          ];
        };
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
          ];
        };
      };
    };

    networking-extra = {
      nixos = {
        programs = {
          bandwhich.enable = true;
          trippy.enable = true;
        };

        services = {
          #aria2.enable = true; NEEDS KEY
          #openvpn.package = true;
          croc.enable = true;
          dnsmasq.enable = true;
          tailscale = {
            enable = true;
            openFirewall = true;
            extraUpFlags = [
              "--accept-dns=true"
              "--accept-routes"
            ];
          };
          ttyd = {
            enable = true;
            writeable = true;
          };
        };
      };
      homeManager = {
        services.pbgopy.enable = true;
        programs.himalaya.enable = true;
      };
    };
  };
}

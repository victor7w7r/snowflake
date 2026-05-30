{ lib, hosts-attrs, ... }:
{
  den.aspects.networking.provides.network-manager = {
    nixos = {
      environment.persistence."/nix/persist".directories = lib.mkAfter [
        "/etc/NetworkManager/system-connections"
        "/var/lib/NetworkManager"
      ];

      networking = {
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

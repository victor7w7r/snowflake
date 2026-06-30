{ lib, ... }:
{
  den.aspects.networking.manager.nixos =
    {
      isPersistent,
      isPhone,
      isServer,
      ...
    }:
    {
      environment = lib.optionalAttrs (isPersistent || !isServer) {
        persistence."/nix/persist".directories = lib.mkAfter [
          "/etc/NetworkManager/system-connections"
          "/var/lib/NetworkManager"
        ];
      };
      systemd.services.NetworkManager-wait-online.enable = false;
      networking = {
        dhcpcd = {
          enable = true;
          wait = "background";
        };
        networkmanager = {
          enable = !isServer;
          #settings.main.rc-manager = "resolvconf";
          #wifi.powersave = false;
          insertNameservers = [
            "8.8.8.8"
            "8.8.4.4"
          ];
          dhcp = "dhcpcd";
          unmanaged = lib.optionals isPhone [
            "rndis0"
            "usb0"
          ];
        };
        modemmanager.enable = lib.mkForce isPhone;
        nameservers = [
          "8.8.8.8"
          "8.8.4.4"
        ];
      };
    };
}

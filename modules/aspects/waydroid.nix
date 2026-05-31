{ lib, ... }:
{
  den.aspects.waydroid = {
    nixos =
      { user, pkgs, ... }:
      {
        virtualisation.waydroid.enable = true;
        environment = {
          persistence."/nix/persist" = {
            directories = lib.mkAfter [ "/var/lib/waydroid" ];
            users."${user}".directories = [ ".local/share/waydroid" ];
          };
          systemPackages = with pkgs; [ waydroid-helper ];
        };
        systemd = {
          packages = with pkgs; [ waydroid-helper ];
          services.waydroid-mount.wantedBy = [ "multi-user.target" ];
        };
      };
  };
}

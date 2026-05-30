{
  den.aspects.waydroid = {
    nixos =
      { user, pkgs, ... }:
      {
        environment = {
          persistence."/nix/persist".users."${user}".directories = [
            ".local/share/waydroid"
          ];
          systemPackages = with pkgs; [ waydroid-helper ];
        };
        virtualisation.waydroid.enable = false;
        systemd = {
          packages = with pkgs; [ waydroid-helper ];
          services.waydroid-mount.wantedBy = [ "multi-user.target" ];
        };
      };
  };
}

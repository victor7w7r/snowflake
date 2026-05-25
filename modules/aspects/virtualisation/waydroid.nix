{ lib, hosts-attrs, ... }:
{
  den.aspects.virtualisation.provides = lib.genAttrs hosts-attrs.softwaregui (t: {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ waydroid-helper ];
        virtualisation.waydroid.enable = false;
        systemd = {
          packages = with pkgs; [ waydroid-helper ];
          services.waydroid-mount.wantedBy = [ "multi-user.target" ];
        };
      };
  });

}

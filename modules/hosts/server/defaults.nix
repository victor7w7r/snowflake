{ den, lib, ... }:
{
  den.aspects.server = {
    includes = [ ];

    nixos =
      { pkgs, user, ... }:
      {

        environment.systemPackages = with pkgs; [
          mdadm
          intel-undervolt
        ];

        services = {
          lvm.boot.thin.enable = true;
          rustdesk.enable = true;
        };
      };
  };
}

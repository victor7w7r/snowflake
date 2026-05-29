{ __findFile, ... }:
{
  den = {
    hosts.x86_64-linux.server.users.victor7w7r = { };

    aspects.server = {
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
  };
}

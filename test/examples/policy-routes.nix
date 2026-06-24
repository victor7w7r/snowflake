{ den, ... }:
{
  den.policies.database-to-services =
    { host, ... }:
    [
      (den.lib.policy.route {
        fromClass = "database"; # NEW CLASS
        intoClass = host.class; # nixos or darwin
        path = [
          "services"
          "postgresql"
        ]; # NIXOS PATH
      })
    ];

  den.aspects.db-server = {
    # nixos.services.postgresql.enable = true; #SHORTCUT TO
    database.enable = true;
    database.dataDir = "/var/lib/postgresql";
  };

  den.default.includes = [ den.policies.database-to-services ];

}

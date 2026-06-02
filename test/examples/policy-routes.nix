{ den, lib, ... }:
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

  test-route-class-into-subpath =
    { den, igloo, ... }:
    {
      den.hosts.x86_64-linux.igloo.users.tux = { };

      den.classes.src.description = "Source class for subpath route";

      den.policies.route-src-subpath =
        { host, ... }:
        [
          (den.lib.policy.route {
            fromClass = "src";
            intoClass = host.class;
            path = [ "route-box" ];
          })
        ];

      den.default.includes = [ den.policies.route-src-subpath ];

      den.aspects.igloo = {
        # nixos.imports = [ (mkListSubmodule "route-box") ];
        nixos.route-box.items = [ "from-nixos-owned" ];
        src.items = [ "from-src-class" ];
      };

      expr = lib.sort (a: b: a < b) igloo.route-box.items;
      expected = [
        "from-nixos-owned"
        "from-src-class"
      ];
    };
}

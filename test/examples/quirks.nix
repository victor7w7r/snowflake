{ den, igloo, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };
  den.quirks.firewall = {
    description = "Firewall port declarations";
  };

  den.aspects.igloo = {
    includes = [
      den.aspects.nginx
      den.aspects.postgres
      den.aspects.networking
    ];
  };

  den.aspects.nginx = {
    nixos.services.nginx.enable = true;
    firewall = {
      ports = [
        80
        443
      ];
    };
  };
  den.aspects.postgres = {
    nixos.services.postgresql.enable = true;
    firewall = {
      ports = [ 5432 ];
    };
  };

  den.aspects.networking = {
    nixos =
      { firewall, lib, ... }:
      {
        networking.firewall.allowedTCPPorts = lib.concatMap (f: f.ports or [ ]) firewall;
      };
  };

  expr = igloo.networking.firewall.allowedTCPPorts;
  expected = [
    80
    443
    5432
  ];
}

{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.aspects.infra = {
    provides.monitoring.nixos.services.prometheus.enable = true;
    networking.nixos.networking.firewall.enable = true;
  };

  den.aspects.igloo.includes = [
    den.aspects.infra._
    den.aspects.infra._.monitoring
  ];
}

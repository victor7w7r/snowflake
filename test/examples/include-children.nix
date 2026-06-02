{
  den,
  igloo,
  ...
}:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.aspects.servers.web.nixos.networking.hostName = "web-host";
  den.aspects.servers.db.nixos.services.postgresql.enable = true;

  den.aspects.igloo.includes = [ den.aspects.servers._ ];
}

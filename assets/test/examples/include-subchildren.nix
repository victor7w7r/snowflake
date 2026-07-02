{ den, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.aspects.top.mid.deep.nixos.services.openssh.enable = true;
  den.aspects.top.mid.shallow.nixos.services.timesyncd.enable = true;

  den.aspects.igloo.includes = [ den.aspects.top.mid._ ];
}

{
  den,
  igloo,
  ...
}:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  den.aspects.top.mid.deep.nixos.services.openssh.enable = true;
  den.aspects.top.mid.shallow.nixos.services.timesyncd.enable = true;

  # mid._ should collect deep and shallow
  den.aspects.igloo.includes = [ den.aspects.top.mid._ ];

  expr = {
    ssh = igloo.services.openssh.enable;
    time = igloo.services.timesyncd.enable;
  };
  expected = {
    ssh = true;
    time = true;
  };
}

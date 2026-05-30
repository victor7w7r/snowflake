{ den, ... }:
{
  den.aspects.server = {
    includes = with den.aspects.server._; [
      containers
      harmonia
      networking
      proxmox
      tunnel
    ];
  };
}

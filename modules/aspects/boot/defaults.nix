{ den, ... }:
{
  den.aspects.boot.includes = with den.aspects.boot._; [
    initrd
    modprobe
  ];
}

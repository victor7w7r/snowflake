{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      fsarchiver
    ]
    ++ [
      cpulimit
      dippi
      dmidecode
      edid-decode
      edid-generator
      fanctl
      fan2go
      hwinfo
      read-edid
      rwedid
    ];

}

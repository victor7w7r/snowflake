{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      iio-sensor-proxy
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

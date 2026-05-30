{
  den.aspects.base.provides.nettools.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        curlFull
        ethtool
        inetutils
        iptables
        net-tools
        wget
        wget2
        wol
      ];
    };
}

{ ... }:
{
  den.aspects.base.provides.coreutils = {
    nixos =
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
  };
}

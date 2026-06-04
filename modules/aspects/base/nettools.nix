{
  den.aspects.base.nettools = {
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
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ axel ];
      };
  };
}

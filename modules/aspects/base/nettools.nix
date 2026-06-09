{
  den.aspects.base.nettools = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          curlFull
          inetutils
          wget
          wol
        ];
      };

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          ethtool
          iptables
          net-tools
          wget2
        ];
      };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ axel ];
      };
  };
}

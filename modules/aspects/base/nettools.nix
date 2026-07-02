{
  den.aspects.base.nettools = {
    provides.to-users.homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ axel ];
      };

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
  };
}

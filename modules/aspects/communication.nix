{
  den.aspects.communication.nixos =
    { pkgs, self', ... }:
    {
      environment.systemPackages = with pkgs; [
        self'.packages.carbonyl
        self'.packages.mabel
        discordo
        nchat
        reader
        stig
        #https://github.com/fetchcord/FetchCord
        #https://github.com/sparklost/endcord
        #https://github.com/anlar/tewi
      ];
    };
}

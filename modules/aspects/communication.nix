{
  den.aspects.communication.nixos =
    { pkgs, self', ... }:
    {
      environment.systemPackages = with pkgs; [
        self'.packages.carbonyl
        self'.packages.mabel
        nchat
        reader
        stig
        #https://github.com/ayn2op/discordo
        #https://github.com/fetchcord/FetchCord
        #https://github.com/sparklost/endcord
        #uv pip install tewi-transmission
        #pkgtop
      ];
    };
}

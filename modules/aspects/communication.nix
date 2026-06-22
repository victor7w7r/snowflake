{
  den.aspects.communication.nixos =
    { pkgs, self', ... }:
    {
      environment.systemPackages = with pkgs; [
        self'.packages.carbonyl
        nchat
        reader
        stig
        #https://github.com/ayn2op/discordo
        #https://github.com/fetchcord/FetchCord
        #https://github.com/sparklost/endcord
        #https://github.com/smmr-software/mabel
        #uv pip install tewi-transmission
        #pkgtop
      ];
    };
}

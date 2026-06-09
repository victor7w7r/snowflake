{
  den.aspects.communication = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          carbonyl
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
  };
}

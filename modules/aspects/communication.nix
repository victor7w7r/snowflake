{
  den.aspects.communication = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          nchat
          reader
          stig
          #(pkgs.callPackage ./custom/carbonyl.nix { })
          #(pkgs.callPackage ./custom/discli.nix { })
          #(pkgs.callPackage ./custom/termishare.nix { })
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

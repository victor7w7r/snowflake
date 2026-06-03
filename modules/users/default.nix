{ den, lib, ... }:
{
  den = {
    schema.user = {
      includes = [ den.batteries.mutual-provider ];
      classes = lib.mkDefault [ "homeManager" ];
    };

    default = {
      homeManager = {
        home.stateVersion = "26.05";
        language.base = "es_ES.UTF-8";
      };
    };
  };
}

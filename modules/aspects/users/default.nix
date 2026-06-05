{ den, lib, ... }:
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den = {
    schema.user = {
      includes = [ den.batteries.mutual-provider ];
      classes = lib.mkDefault [ "homeManager" ];
    };

    default.homeManager = {
      home.stateVersion = "26.05";
      language.base = "es_ES.UTF-8";
      manual = {
        html.enable = lib.mkDefault false;
        json.enable = lib.mkDefault false;
        manpages.enable = lib.mkDefault false;
      };
    };
  };
}

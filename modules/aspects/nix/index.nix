{ inputs, ... }:
{
  flake-file.inputs.nix-index-database = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/nix-index-database";
  };

  den.aspects.nix.index.homeManager = {
    imports = [ inputs.nix-index-database.homeModules.nix-index ];

    programs = {
      nix-index-database.comma.enable = true;
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

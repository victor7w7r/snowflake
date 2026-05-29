{ __findFile, ... }:
{
  flake-file.inputs.darwin = {
    url = "github:nix-darwin/nix-darwin";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den = {
    hosts.x86_64-darwin.main-mac.users.victor7w7r = { };

    aspects.main-mac = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

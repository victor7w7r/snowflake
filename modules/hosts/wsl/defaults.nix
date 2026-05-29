{ __findFile, ... }:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/nixos-wsl";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "";
  };

  den = {
    hosts.x86_64-linux.wsl.users.victor7w7r = { };

    aspects.wsl = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

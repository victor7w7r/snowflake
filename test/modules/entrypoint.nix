{
  lib,
  __findFile ? __findFile,
  ...
}:
{
  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den = {
    hosts.x86_64-linux.generic = {
      hostName = "v7w7r-generic";
      users.victor7w7r = { };
    };
    default = {
      darwin.system.stateVersion = 6;
      nixos.system.stateVersion = "25.05";
      homeManager.home.stateVersion = "25.05";

      includes = [
        <den/hostname>
      ];
    };
  };

}

{ ... }:
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
  };

  den.hosts = {
    x86_64-linux = {
      main.users.victor7w7r = { };
      handheld.users.victor7w7r = { };
      server.users.victor7w7r = { };
      generic.users.victor7w7r = { };

      live.users.snowflake = { };
    };

    aarch64-linux = {
      pizero.users.victor7w7r = { };
      phone.users.victor7w7r = { };
      superlab.users.victor7w7r = { };
    };

    x86_64-darwin.main = {
      users.victor7w7r = { };
    };
  };
}

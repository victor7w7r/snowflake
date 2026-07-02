{
  den,
  inputs,
  ...
}:
{
  flake-file.inputs.nixos-wsl = {
    url = "github:nix-community/nixos-wsl";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "";
  };

  imports = [ (inputs.den.namespace "wsl" false) ];

  den = {
    hosts.x86_64-linux.wsl = {
      wsl.enable = true;
      users.victor7w7r = { };
    };

    aspects.wsl = {
      includes = with den.aspects; [
        base._
        base.tmux._
        base.shell._
        dev._
        networking._
        nix
        tweaks._
        vim._

        btrfs
        fetch
        persistence
        secrets
        victor7w7r
      ];

      nixos = {
        networking.hostName = "v7w7r-wsl";
      };
    };
  };
}

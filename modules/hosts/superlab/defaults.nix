{ __findFile, ... }:
{
  den = {
    hosts.aarch64-linux.superlab = {
      hostName = "v7w7r-radxarock5b";
      users.victor7w7r = { };
    };

    aspects.superlab = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

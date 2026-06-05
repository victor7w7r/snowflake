{ inputs, __findFile, ... }:
{
  imports = [ (inputs.den.namespace "superlab" false) ];

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

{ __findFile, ... }:
{
  den = {
    hosts.aarch64-linux.pizero = {
      hostName = "v7w7r-opizero2w";
      users.victor7w7r = { };
    };

    aspects.phone = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

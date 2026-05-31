{ __findFile, ... }:
{
  flake-file.inputs.mobile-nixos = {
    url = "github:mobile-nixos/mobile-nixos";
    flake = false;
  };

  den = {
    hosts.aarch64-linux.phone.users.victor7w7r = { };

    aspects.phone = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

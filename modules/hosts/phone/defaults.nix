{ phone, __findFile, ... }:
{
  flake-file.inputs.mobile-nixos = {
    url = "github:mobile-nixos/mobile-nixos";
    flake = false;
  };

  den = {
    hosts.aarch64-linux.phone-enchilada = {
      hostName = "v7w7r-enchilada";
      users.victor7w7r = { };
    };
    hosts.aarch64-linux.phone-fajita = {
      hostName = "v7w7r-fajita";
      users.victor7w7r = { };
    };

    aspects.phone = {
      includes = [ ];

      nixos = {
      };
    };
  };
}

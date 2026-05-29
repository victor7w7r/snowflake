{ lib, generic, ... }:
{
  den = {
    hosts.x86_64-linux.generic.users.snowflake = { };
    aspects.generic = {
      includes = [
        generic.disks
      ];

      nixos = {
      };
    };
  };
}

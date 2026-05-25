{ den, lib, ... }:
{
  den.aspects.handheld = {
    includes = [ ];

    nixos = {
      environment.persistence."/nix/persist".directories = lib.mkAfter [
        "/etc/asusd"
        "/etc/hhd"
      ];
    };
  };
}

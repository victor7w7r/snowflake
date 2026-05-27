{
  den.aspects.secureboot.nixos =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          mokutil
          tpm2-tools
          sbctl
        ];
        persistence."/nix/persist".directories = [
          "/var/lib/containers"
          "/var/lib/nixos-containers"
          "/var/lib/sbctl"
        ];
      };
    };
}

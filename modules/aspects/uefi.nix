{
  den.aspects = {
    uefi.nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          efibooteditor
          efibootmgr
        ];
      };

    secureboot-persistence.nixos.persistence."/nix/persist".directories = [
      "/var/lib/containers"
      "/var/lib/nixos-containers"
      "/var/lib/sbctl"
    ];

    secureboot.nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          mokutil
          tpm2-tools
          sbctl
        ];
      };
  };
}

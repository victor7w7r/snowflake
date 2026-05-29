{ lib, handheld, ... }:
{
  den = {
    hosts.x86_64-linux.generic.handheld.victor7w7r = { };
    aspects.handheld = {
      includes = [
        handheld.kernel
        handheld.disks
        handheld.hardware
        handheld.services
      ];

      nixos =
        { pkgs, user, ... }:
        {
          environment = {
            persistence."/nix/persist" = {
              directories = lib.mkAfter [
                "/etc/asusd"
                "/etc/hhd"
              ];
              users."${user}".directories = [ ".config/rog" ];
            };
            systemPackages = with pkgs; [
              asusctl
              amdgpu_top
              brightnessctl
              kdePackages.plasma-thunderbolt
              radeontop
              ryzenadj
              tbtools
              qjoypad
              thunderbolt
            ];
          };

          systemd.services.supergfxd.path = with pkgs; [
            kmod
            pciutils
          ];

          programs.rog-control-center = {
            enable = true;
            autoStart = true;
          };
        };
    };
  };
}

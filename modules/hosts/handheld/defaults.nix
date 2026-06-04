{
  inputs,
  lib,
  handheld,
  ...
}:
{
  imports = [ (inputs.den.namespace "handheld" false) ];

  den = {
    hosts.x86_64-linux.handheld = {
      hostName = "v7w7r-rc71l";
      users.victor7w7r = { };
    };
    aspects.handheld = {
      includes = [
        handheld.disks
        handheld.hardware
        handheld.initrd
        handheld.kernel
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

            boot.extraModprobeConfig = "options kvm-amd nested=1";

            zramSwap = {
              enable = true;
              algorithm = "zstd";
              memoryPercent = 60;
              priority = 100;
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

          services.lact.enable = true;

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

    homeManager =
      { config, ... }:
      {
        home.file."games".source = config.lib.file.mkOutOfStoreSymlink "/run/media/games";
      };
  };
}

{
  den,
  inputs,
  lib,
  handheld,
  initrd-services,
  kernel,
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
      includes = with den.aspects; [
        handheld.disks
        handheld.hardware
        handheld.initrd
        handheld.services
        (initrd-services.lib.zram { })

        kernel.rogally

        base._
        base.tmux._
        base.shell._
        dev._
        gui._
        initrd._
        networking._
        nix._
        plasma._
        sound._
        tweaks._
        vim._
        virtualisation._
        zen._

        android
        bluetooth
        btrfs
        fetch
        gaming
        hardware
        kitty
        secrets
        victor7w7r
        zed
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
              users."${user.name}".directories = [ ".config/rog" ];
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

          boot = {
            extraModprobeConfig = "options kvm-amd nested=1";
            resumeDevice = "/dev/mapper/swapcrypt";
            kernelPackages = pkgs.handheld-kernelPackages;
            kernelParams = [
              "resume=/dev/mapper/swapcrypt"
            ];
          };

          zramSwap = {
            enable = true;
            algorithm = "zstd";
            memoryPercent = 60;
            priority = 100;
          };

          swapDevices = [
            {
              device = "/dev/mapper/swapcrypt";
              discardPolicy = "both";
              options = [ "nofail" ];
            }
          ];

          systemd.services.supergfxd.path = with pkgs; [
            kmod
            pciutils
          ];

          programs.rog-control-center = {
            enable = true;
            autoStart = true;
          };
        };

      homeManager =
        { config, ... }:
        {
          home.file."games".source = config.lib.file.mkOutOfStoreSymlink "/run/media/games";
        };
    };

  };
}

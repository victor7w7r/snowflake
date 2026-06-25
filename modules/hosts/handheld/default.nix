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

        kernel.handheld

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
        { pkgs, ... }:
        {
          environment = {
            persistence."/nix/persist" = {
              directories = lib.mkAfter [
                "/etc/asusd"
                "/etc/hhd"
              ];
              #users."${user.name}".directories = [ ".config/rog" ];
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
            kernelPatches = [
              {
                name = "nixos-systemd-structured-required";
                patch = null;
                extraConfig = ''
                  DEVTMPFS y
                  DEVTMPFS_MOUNT y
                  CGROUPS y
                  INOTIFY_USER y
                  SIGNALFD y
                  TIMERFD y
                  EPOLL y
                  SYSFS y
                  PROC_FS y
                  FHANDLE y
                  BINFMT_ELF y
                  BLK_DEV_INITRD y

                  NET y
                  UNIX y
                  SWAP y

                  TMPFS y
                  TMPFS_POSIX_ACL y
                  TMPFS_XATTR y

                  SECCOMP y
                  CRYPTO_USER_API_HASH y
                  CRYPTO_HMAC y
                  CRYPTO_SHA256 y

                  # Varios requeridos por el validador de NixOS
                  DMIID y
                  AUTOFS_FS y
                  ZRAM y
                '';
              }
            ];
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

{
  den,
  inputs,
  main,
  ...
}:
{
  imports = [ (inputs.den.namespace "main" false) ];
  #nixos-hardware.nixosModules.apple-t2

  den = {
    hosts.x86_64-linux.main = {
      hostName = "v7w7r-macmini81";
      users.victor7w7r = { };
    };

    aspects.main = {
      includes = with den.aspects; [
        main.audio
        main.disks
        main.initrd
        main.services

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
        forensics
        hardware
        kitty
        secrets
        victor7w7r
        zed
      ];
      #audioT2 = (pkgs.callPackage ./custom/t2-pipewire.nix { });
      nixos = {
        /*
          let
            helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };
            kernelBuild = (pkgs.callPackage ../kernel) {
              inherit
                helpers
                host
                kernelData
                inputs
                ;
            };
            params = import ./lib/kernel-params.nix;
            boot = (import ./lib/boot.nix) {
              emergencyDisk = "ssd";
            };
            bcachefs = (import ./lib/bcachefs.nix);
            xfs = (import ./lib/xfs.nix);
            shared = (import ./lib/shared.nix) { };
            audio = (pkgs.callPackage ./custom/apple-t2-better-audio.nix { });
          in
          {
            fileSystems = {
              inherit (boot) "/boot" "/boot/emergency";
              inherit (shared) "/run/media/shared";

              "/" = {
                device = "/dev/zram1";
                fsType = "ext4";
                neededForBoot = true;
                options = [
                  "noatime"
                  "x-systemd.device-timeout=0"
                ];
              };

              "/nix" = bcachefs {
                extraOptions = [
                  "X-mount.subdir=subvolumes/nix"
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
              };

              "/nix/persist/etc" = bcachefs {
                extraOptions = [
                  "X-mount.subdir=subvolumes/etc"
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
              };

              "/nix/persist" = xfs {
                depends = [ "/nix" ];
                extraOptions = [ "logdev=/dev/mapper/persistlogcrypt" ];
              };

              "/nix/persist/storage" = xfs {
                device = "/dev/vg1/storage";
                depends = [ "/nix/persist" ];
                extraOptions = [ "logdev=/dev/mapper/storagelogcrypt" ];
              };
              };
        */

        boot = {
          /*
            extraModulePackages = [
            (pkgs.callPackage ./custom/apple-bce.nix { kernel = kernelBuild.kernel; })
            ];
          */
          # kernelPackages = lib.mkForce (helpers.kernelModuleLLVMOverride (kernelBuild.packages));
          resumeDevice = "/dev/mapper/swapcrypt";
        };

        swapDevices = [
          {
            device = "/dev/mapper/swapcrypt";
            discardPolicy = "both";
            options = [ "nofail" ];
          }
        ];
        systemd.tmpfiles.rules = [
          "w /sys/block/bcache0/bcache/cache_mode - - - - writethrough"
          "w /sys/block/bcache1/bcache/cache_mode - - - - writethrough"
        ];
      };

      homeManager =
        { config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "storage".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/storage";
          };
        };
    };
  };
}

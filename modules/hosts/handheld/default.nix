{
  inputs,
  lib,
  handheld,
  ...
}:
{
  imports = [ (inputs.den.namespace "handheld" false) ];
  #nixos-hardware.nixosModules.asus-ally-rc71l

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
          /*
            let
              params = import ./lib/kernel-params.nix;
              boot = (import ./lib/boot.nix) { };
              helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" { };
              kernelBuild = (pkgs.callPackage ../kernel) {
                inherit
                  helpers
                  host
                  kernelData
                  inputs
                  ;
              };
              bcachefs = (import ./lib/bcachefs.nix);
              shared = (import ./lib/shared.nix) {
                sharedDir = "/run/media/games";
                partlabel = "games";
              };
            in

            fileSystems = {
              inherit (boot) "/boot" "/boot/emergency";
              inherit (shared) "/run/media/games";

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
                device = "/dev/disk/by-partlabel/disk-main-system";
                extraOptions = [
                  "X-mount.subdir=subvolumes/nix"
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
              };

              "/nix/persist" = bcachefs {
                device = "/dev/disk/by-partlabel/disk-main-system";
                extraOptions = [
                  "X-mount.subdir=subvolumes/persist"
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
                depends = [ "/nix" ];
              };
            };
          */
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

          services.lact.enable = true;

          boot = {
            extraModprobeConfig = "options kvm-amd nested=1";
            resumeDevice = "/dev/mapper/swapcrypt";
            kernelParams = [
              "resume=/dev/mapper/swapcrypt"
              "amd_pstate=passive"
            ];
            #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-lto;
            #kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
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
    };

    homeManager =
      { config, ... }:
      {
        home.file."games".source = config.lib.file.mkOutOfStoreSymlink "/run/media/games";
      };
  };
}

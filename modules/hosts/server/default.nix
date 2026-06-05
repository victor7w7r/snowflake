{ inputs, server, ... }:
{
  imports = [ (inputs.den.namespace "server" false) ];

  /*
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-hardware.nixosModules.common-cpu-intel
  */

  den = {
    hosts.x86_64-linux.server = {
      hostName = "v7w7r-youyeetoox1";
      users.victor7w7r = { };
    };

    aspects.server = {
      includes = [
        server.disks-logical
        server.disks-physical
      ];

      nixos =
        { config, pkgs, ... }:
        {
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
                efiDisk = "emmc";
                emergencyDisk = "nvme";
              };
              f2fs = import ./lib/f2fs.nix;
              xfs = (import ./lib/xfs.nix);
            in
            fileSystems = {
              inherit (boot) "/boot" "/boot/emergency";
              "/" = {
                device = "/dev/zram1";
                fsType = "ext4";
                neededForBoot = true;
                options = [
                  "noatime"
                  "x-systemd.device-timeout=0"
                ];
              };

              "/run/media/shared" = f2fs {
                label = "shared";
                neededForBoot = false;
              };

              "/nix" = f2fs {
                label = "store";
                depends = [ "/" ];
              };

              "/nix/persist" = xfs {
                depends = [ "/nix" ];
                device = "/dev/mapper/persist";
                extraOptions = [
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
              };

              "/nix/persist/cloud" = xfs {
                depends = [ "/nix/persist" ];
                device = "/dev/vg0/cloud";
                extraOptions = [
                  "largeio"
                  "swalloc"
                  "sunit=1024"
                  "swidth=4096"
                  "inode64"
                  "logdev=/dev/mapper/cloudlogcrypt"
                  "x-systemd.device-timeout=300"
                  "x-systemd.mount-timeout=300"
                ];
              };
            };
          */

          boot = {
            initrd.services.lvm.enable = true;
            extraModulePackages = [ config.boot.kernelPackages.r8168 ];
            blacklistedKernelModules = [ "r8169" ];
            resumeDevice = "/dev/mapper/swapcrypt";
            kernelParams = [ "pcie_aspm=off" ];
            #kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
            swraid = {
              enable = true;
              mdadmConf = ''
                MAILADDR root
                ARRAY /dev/md/raid0 metadata=1.2 spares=1 UUID=00a19bfc:a0b32154:4ed293e4:28565a8f
              '';
            };
          };

          environment.systemPackages = with pkgs; [
            mdadm
            intel-undervolt
          ];

          zramSwap = {
            enable = true;
            algorithm = "zstd";
            memoryPercent = 100;
            priority = 100;
          };

          services = {
            lvm.boot.thin.enable = true;
            rustdesk.enable = true;
          };

          swapDevices = [
            {
              device = "/dev/mapper/swapcrypt";
              discardPolicy = "both";
              options = [ "nofail" ];
            }
          ];
        };

      homeManager =
        { user, config, ... }:
        {
          home.file = {
            "shared".source = config.lib.file.mkOutOfStoreSymlink "/run/media/shared";
            "cloud".source = config.lib.file.mkOutOfStoreSymlink "/nix/persist/cloud";
            ".xinitrc".text = ''
              export XAUTHORITY=/home/${user}/.Xauthority
              export XDG_SESSION_TYPE=x11
              export DESKTOP_SESSION=xfce
              exec startxfce4
            '';
          };
        };
    };
  };
}

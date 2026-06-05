{ inputs, __findFile, ... }:
{
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.toplevel"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.sdImage"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.tarball"
  #nix build -L ".#nixosConfigurations.opizero2w.config.system.build.bootFiles"
  #dd if=u-boot-sunxi-with-spl.bin of=/dev/sde bs=1024 seek=8 conv=notrunc
  #mount /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf boot.tar.zst -C /mnt/ --no-same-owner && umount /dev/sde1 && udisksctl power-off -b /dev/sde
  #mount -o noatime,nodiratime,lazytime,logbufs=8,logbsize=256k /dev/sde1 /mnt && rm -rf /mnt/* && tar --zstd -xvf store.tar.zst -C /mnt/ && sync && umount /dev/sde1 && udisksctl power-off -b /dev/sde

  imports = [ (inputs.den.namespace "pizero" false) ];

  den = {
    hosts.aarch64-linux.pizero = {
      hostName = "v7w7r-opizero2w";
      users.victor7w7r = { };
    };

    aspects.phone = {
      includes = [ ];

      nixos = {
        /*
          let
            #uboot = import ./custom/sunxi-uboot.nix { inherit pkgs; };
            f2fs = import ./lib/f2fs.nix;
            kernel = (pkgs.callPackage ../kernel/sunxi) { inherit kernelData; };
            #cp ${uboot}/u-boot-sunxi-with-spl.bin $out/
          in
          {
            imports = [
                (import ./soc {
                inherit config pkgs host;
                postBuildCommands = "dd if=${uboot}/u-boot-sunxi-with-spl.bin of=boot.img bs=1024 seek=8 conv=notrunc";
                populateFirmwareCommands = ''
                  mkdir -p firmware/boot
                  ${config.boot.loader.generic-extlinux-compatible.populateCmd} \
                    -c ${config.system.build.toplevel} -d firmware/boot
                '';
                })

              (import ./lib/tarball.nix {
                inherit config pkgs;
                additionalContent = bootFiles;
              })
            ];

            fileSystems = {
              "/" = {
                device = "none";
                fsType = "tmpfs";
                options = [
                  "defaults"
                  "size=2G"
                  "mode=755"
                ];
              };
              "/boot" = {
                device = "/dev/disk/by-label/BOOT";
                fsType = "vfat";
                options = [
                  "nofail"
                  "noauto"
                ];
              };
              "/nix" = {
                device = "/dev/disk/by-label/store";
                neededForBoot = true;
                fsType = "xfs";
                options = [
                  "noatime"
                  "nodiratime"
                  "lazytime"
                  "logbufs=8"
                  "logbsize=256k"
                ];
              };
              "/nix/persist" = f2fs {
                label = "persist";
                device = "/dev/disk/by-label/persist";
                depends = [ "/nix" ];
              };
            };
        */
        networking.wireless.enable = true;
        systemd.tmpfiles.rules = [ "L+ /lib/firmware - - - - /run/current-system/firmware" ];

        boot = {
          kernelParams = [
            "earlycon"
            "console=ttyS0,115200n8"
          ];
          initrd.kernelModules = [
            "g_ether"
            "sdhci"
            "sdhci_pci"
            "uas"
            "sunxi_gmac"
            "libcomposite"
          ];
          loader = {
            grub.enable = false;
            generic-extlinux-compatible.enable = true;
          };
          # kernelPackages = kernel.packages;
        };

        zramSwap = {
          enable = true;
          algorithm = "zstd";
          memoryPercent = 100;
          priority = 100;
        };

        hardware.deviceTree = {
          enable = true;
          name = "allwinner/sun50i-h618-orangepi-zero2w.dtb";
        };
      };
    };
  };
}

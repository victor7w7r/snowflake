{
  inputs,
  kernelData,
  config,
  lib,
  pkgs,
  ...
}:
let
  kernel = (pkgs.callPackage ../kernel/sdm845) { inherit kernelData; };
  f2fs = import ./lib/f2fs.nix;
  uboot = pkgs.callPackage ../kernel/sdm845/uboot.nix { device = "fajita"; };
  shell = "${
    pkgs.edk2-uefi-shell.overrideAttrs { env.NIX_CFLAGS_COMPILE = "-Wno-error=maybe-uninitialized"; }
  }/shell.efi";
  bootFiles =
    let
      vmlinux = "${config.boot.kernelPackages.kernel}/Image";
      ofox = pkgs.fetchurl {
        url = "https://github.com/Wishmasterflo/ofox_fajita/releases/download/V7/OrangeFox-R12.0-Unofficial-fajita-V7.img";
        sha256 = "sha256-YeufeirpubeGhq2ORkQA7z/ZCo7XzqggUoOiPXK7PTQ=";
      };
      initrd = "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";
    in
    ''
      mkdir -p boot/EFI/BOOT boot/loader/entries boot/EFI/nixos

      cp ${uboot}/sdm845-oneplus-fajita.dtb boot/EFI/nixos/sdm845-oneplus-fajita.dtb
      cp ${vmlinux} boot/EFI/nixos/vmlinuz && cp ${initrd} boot/EFI/nixos/initrd && cp ${ofox} boot/ofox.img && cp ${shell} boot/EFI/shell.efi
      cp ${../kernel/sdm845/dtbo.img} boot/dtbo.img && cp ${uboot}/boot.img boot/uboot.img
      cp ${../kernel/sdm845/parted} boot/parted

      cp ${pkgs.systemd}/lib/systemd/boot/efi/systemd-bootaa64.efi boot/EFI/BOOT/BOOTAA64.EFI
      echo "timeout 3" > boot/loader/loader.conf
      echo "console-mode keep" >> boot/loader/loader.conf
      echo "auto-reboot true" >> boot/loader/loader.conf
      echo "auto-reboot-to-firmware-setup true" >> boot/loader/loader.conf
      echo "auto-poweroff true" >> boot/loader/loader.conf

      echo "title NixOS" > boot/loader/entries/nix.conf
      echo "linux /EFI/nixos/vmlinuz" >> boot/loader/entries/nix.conf
      echo "initrd /EFI/nixos/initrd" >> boot/loader/entries/nix.conf
      echo "options init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams}" >> boot/loader/entries/nix.conf
      #echo "devicetree /EFI/nixos/sdm845-oneplus-fajita.dtb" >> boot/loader/entries/nix.conf

      echo "title Shell" > boot/loader/entries/shell.conf
      echo "efi /EFI/shell.efi" >> boot/loader/entries/shell.conf

      tar -cv -C boot . | zstd -T$NIX_BUILD_CORES > $out/efi.tar.zst

      cat <<EOF > $out/switch-uboot.sh
      #!/bin/sh

      mount -t vfat /dev/block/by-name/esp /mnt
      dd if=/dev/zero of=/dev/block/by-name/dtbo_a bs=4096 conv=notrunc,fsync
      dd if=/dev/zero of=/dev/block/by-name/dtbo_b bs=4096 conv=notrunc,fsync
      dd if=/mnt/uboot.img of=/dev/block/by-name/boot_a bs=4096 conv=notrunc,fsync
      dd if=/mnt/uboot.img of=/dev/block/by-name/boot_b bs=4096 conv=notrunc,fsync
      reboot
      EOF

      cp ${uboot}/boot.img $out/
    '';
in
{

  system.build.bootFiles = pkgs.stdenvNoCC.mkDerivation {
    name = "bootFiles";
    nativeBuildInputs = with pkgs; [ zstd ];
    version = "1.0.0";
    buildCommand = ''
      mkdir -p $out
      ${bootFiles}
    '';
  };

  nixpkgs.overlays = [
    (_: prev: {
      makeModulesClosure = x: prev.makeModulesClosure (x // { allowMissing = true; });
    })
    (pkgs: prev: {
      mkbootimg = pkgs.callPackage "${inputs.mobile-nixos}/overlay/mkbootimg" { };
    })
  ];

  imports = [
    (import ./lib/qcom-845.nix {
      inherit
        inputs
        kernelData
        config
        lib
        pkgs
        ;
    })

    (import ./lib/tarball.nix {
      inherit config pkgs;
      additionalContent = bootFiles;
    })
  ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-partlabel/esp";
      fsType = "vfat";
      options = [
        "lazytime"
        "noatime"
        "umask=0077"
        "dmask=0077"
        "codepage=437"
        "iocharset=ascii"
        "shortname=mixed"
        "errors=remount-ro"
        "nofail"
      ];
    };
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "defaults"
        "size=2G"
        "mode=755"
      ];
    };
    "/nix" = f2fs {
      label = "userdata";
      device = "/dev/disk/by-partlabel/userdata";
    };
  };

  boot = {
    kernelPackages = kernel.packages;
    consoleLogLevel = 4;
    loader = {
      grub.enable = false;
      systemd-boot.enable = lib.mkForce true;
      systemd-boot.extraFiles.${config.hardware.deviceTree.name} =
        "${config.hardware.deviceTree.package}/${config.hardware.deviceTree.name}";
      efi.canTouchEfiVariables = false;
      systemd-boot.consoleMode = "0";
    };
    blacklistedKernelModules = [
      "qcrypto"
      "ipa"
    ];
    kernelParams = [
      "clk_ignore_unused"
      "pd_ignore_unused"
      "arm64.nopauth"
      "console=ttyMSM0,115200n8"
      "console=tty0"

      "rd.systemd.default_standard_output=kmsg+console"
      "rd.systemd.default_standard_error=kmsg+console"
      "rd.systemd.journald.forward_to_console=1"
      "rd.systemd.log_target=console"
      "rd.systemd.journald.forward_to_console=1"
    ];
    initrd = {
      includeDefaultModules = false;
      systemd = {
        tpm2.enable = false;
        extraBin.buffyboard = "${(pkgs.callPackage ./custom/buffybox.nix { })}/bin/buffyboard";
        contents."/share".source = "${pkgs.libinput.out}/share";
        storePaths = [ pkgs.libinput ];
      };
      kernelModules = [
        "qcom_pd_mapper"
        "sd_mod"
        "scsi_mod"
        "dm_mod"
        "ufshcd-core"
        "ufs-qcom"
        "phy-qcom-qmp-ufs"
      ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 60;
    priority = 100;
  };

  hardware.deviceTree = {
    enable = true;
    name = "dtbs/sdm845-oneplus-fajita.dtb";
  };
}

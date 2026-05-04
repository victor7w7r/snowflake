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
in
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
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
  ];

  system.build.uboot = kernel.uboot;

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
      label = "nixos";
      device = "/dev/disk/by-partlabel/nixos";
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
    kernelParams = [
      "console=ttyMSM0,115200"
      "dtb=/${config.hardware.deviceTree.name}"
    ];
    initrd = {
      systemd = {
        extraBin.buffyboard = "${(pkgs.callPackage ./custom/buffybox.nix { })}/bin/buffyboard";
        contents."/share".source = "${pkgs.libinput.out}/share";
        storePaths = [ pkgs.libinput ];
      };
      kernelModules = [
        "i2c_qcom_geni"
        "rmi_core"
        "rmi_i2c"
        "qcom_spmi_haptics"
        "mmc_block"
      ];

      availableKernelModules = [
        "configfs"
        "libcomposite"
        "g_ffs"
        "usbhid"
        "hid_generic"
        "dm_mod"
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
    name = "qcom/sdm845-oneplus-fajita.dtb";
  };

}

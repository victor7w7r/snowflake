{
  inputs,
  host,
  kernelData,
  lib,
  pkgs,
  ...
}:
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
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

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

  environment.systemPackages = with pkgs; [
    bolt
    tbtools
    thunderbolt
    kdePackages.plasma-thunderbolt
  ];

  services.hardware.bolt.enable = true;
  services.udev.packages = [ audio.audioUdev ];

  boot = {
    extraModulePackages = [
      (pkgs.callPackage ./custom/apple-bce.nix { kernel = kernelBuild.kernel; })
    ];
    resumeDevice = "/dev/mapper/swapcrypt";
    kernelParams = [
      "video=DP-3:1600x900@60"
      "systemd.gpt_auto=0"
      "rootwait"
      "zram.num_devices=2"
    ]
    ++ params { };
    kernelPackages = lib.mkForce (helpers.kernelModuleLLVMOverride (kernelBuild.packages));
    initrd = {
      kernelModules = [
        "apple-bce"
        "aes_ni"
        "brcmfmac_wcc"
        "brcmfmac"
        "btrfs"
        "cryptd"
        "dm_crypt"
        "dm_mod"
        "bcache"
        "uas"
        "usb_storage"
        "ahci"
        "usbhid"
        "sd_mod"
        "uhci_hcd"
        "ehci_hcd"
        "xhci_pci"
        "usbcore"
        "zram"
        # "vfio_virqfd"
        # "vfio_pci"
        # "vfio_iommu_type1"
        # "vfi"
      ];
    };
  };
}

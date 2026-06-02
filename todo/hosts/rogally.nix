{
  host,
  inputs,
  lib,
  pkgs,
  kernelData,
  username,
  ...
}:
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
{
  nixpkgs.overlays = [
    (_final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

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

  swapDevices = [
    {
      device = "/dev/mapper/swapcrypt";
      discardPolicy = "both";
      options = [ "nofail" ];
    }
  ];

  boot = {
    resumeDevice = "/dev/mapper/swapcrypt";
    supportedFilesystems = [ "bcachefs" ];
    kernelParams = [
      "resume=/dev/mapper/swapcrypt"
      "amd_pstate=passive"
      "systemd.gpt_auto=0"
      "rootwait"
      "zram.num_devices=2"
    ]
    ++ params { };
    #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-lto;
    kernelPackages = helpers.kernelModuleLLVMOverride (kernelBuild.packages);
    initrd = {
      checkJournalingFS = lib.mkForce false;
      kernelModules = [
        "dm-snapshot"
        "kvm-amd"
        "cpufreq_reflex"
        "amdgpu"
        "snd_usb_audio"
        "snd_hda_intel"
        "xhci_pci"
        "nvme"
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sdhci_pci"
        "zram"
      ];

      luks.devices.swapcrypt = {
        device = "/dev/disk/by-partlabel/disk-main-swapcrypt";
        crypttabExtraOpts = [ "tpm2-device=auto" ];
        preLVM = true;
      };
    };
  };
}

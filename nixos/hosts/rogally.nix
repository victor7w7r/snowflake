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
      extraOptions = [
        "X-mount.subdir=subvolumes/nix"
        "x-systemd.device-timeout=300"
        "x-systemd.mount-timeout=300"
      ];
    };

    "/nix/persist" = bcachefs {
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

  powerManagement.cpuFreqGovernor = "schedutil";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 60;
    priority = 100;
  };

  boot = {
    resumeDevice = "/dev/mapper/swapcrypt";
    supportedFilesystems = [ "bcachefs" ];
    kernelParams = [
      "resume=/dev/mapper/swapcrypt"
      "amd_pstate=passive"
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
      systemd.services.zram-format = {
        wantedBy = [ "initrd.target" ];
        requiredBy = [ "sysroot.mount" ];
        before = [
          "dev-mapper-persist.device"
          "dev-mapper-storage.device"
          "initrd-fs.target"
          "sysroot.mount"
        ];
        after = [ "systemd-modules-load.service" ];
        unitConfig.DefaultDependencies = false;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        path = [
          pkgs.util-linux
          pkgs.systemd
          pkgs.e2fsprogs
          pkgs.coreutils
        ];
        script = ''
          set -e
          mkdir -p /media

          echo 4G > /sys/block/zram1/disksize
          mkfs.ext4 -m 0 -O "^has_journal,^huge_file,^flex_bg" /dev/zram1
        '';
      };

      luks.devices.syscrypt = {
        device = "/dev/disk/by-partlabel/disk-main-swapcrypt";
        crypttabExtraOpts = [ "tpm2-device=auto" ];
        preLVM = true;
      };
    };
  };

  environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    alsa-plugins
    alsa-utils
    alsa-firmware
    alsa-ucm-conf
    asusctl
    amdgpu_top
    bluetui
    bluetuith
    kdePackages.plasma-thunderbolt
    pciutils
    powertop
    radeontop
    ryzenadj
    tbtools
    qjoypad
    thunderbolt
  ];

  systemd.services.supergfxd.path = [
    pkgs.kmod
    pkgs.pciutils
  ];

  hardware = {
    enableAllFirmware = true;
    amdgpu.opencl.enable = true;
    uinput.enable = true;
    xone.enable = true;
  };

  programs.rog-control-center.enable = true;

  services = {
    acpid.enable = true;
    #auto-cpufreq.enable = true;
    supergfxd = {
      enable = true;
      settings = {
        vfio_enable = true;
        vfio_save = false;
        always_reboot = false;
        no_logind = false;
        logout_timeout_s = 20;
        hotplug_type = "Asus";
      };
    };
    tuned.enable = false;
    inputplumber.enable = lib.mkForce false;
    btrfs.autoScrub = {
      enable = true;
      fileSystems = [ "/run/media/games" ];
      interval = "weekly";
    };

    asusd = {
      enable = true;
      asusdConfig.text = ''
        bat_charge_limit: 80,
        platform_profile_on_battery: Quiet,
        change_platform_profile_on_battery: true,
        platform_profile_on_ac: BalancePerformance,
        change_platform_profile_on_ac: true,
        profile_quiet_epp: Power,
        profile_balanced_epp: BalancePower,
        profile_custom_epp: BalancePerformance,
        profile_performance_epp: BalancePerformance,
      '';
    };
    handheld-daemon = {
      enable = true;
      user = username;
      ui.enable = true;
      adjustor.enable = true;
      adjustor.loadAcpiCallModule = true;
    };
    powerstation.enable = false;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="amdgpu", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/%p/power_dpm_force_performance_level /sys/%p/pp_od_clk_voltage"
      SUBSYSTEM=="usb", ATTR{idVendor}=="2808", ATTR{idProduct}=="a753", MODE="0660", GROUP="input"
    '';
    fprintd = {
      enable = true;
      package = pkgs.fprintd.override {
        libfprint = pkgs.callPackage ./custom/focaltech.nix { };
      };
    };
  };
}

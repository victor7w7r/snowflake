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
    (_: prev: {
      makeModulesClosure = x: prev.makeModulesClosure (x // { allowMissing = true; });
    })
    (final: prev: {
      kdePackages = prev.kdePackages // {
        plasma-workspace = prev.kdePackages.plasma-workspace.overrideAttrs (oldAttrs: {
          cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
            "-DGLIBC_LOCALE_GEN=OFF"
            "-DUBUNTU_PACKAGEKIT=OFF"
            "-DGLIBC_LOCALE_PREGENERATED=ON"
          ];
        });
      };
    })
    (final: prev: {
      libinput = prev.libinput.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
          final.pkg-config
          final.lua5_4
        ];
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.lua5_4 ];
      });
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

    (import ./lib/tarball.nix { inherit config pkgs; })
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
    "/nix" = f2fs {
      label = "NIXOS_SYSTEM";
      device = "/dev/disk/by-label/NIXOS_SYSTEM";
    };
  };

  boot.kernelPackages = kernel.packages;
  boot.kernelParams = lib.mkAfter [
    "earlycon=uart,mmio32,0x01c28000"
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 60;
    priority = 100;
  };

  mobile = {
    system.android.device_name = "OnePlus6T";
    generatedFilesystems.rootfs = lib.mkDefault {
      filesystem = lib.mkForce "btrfs";
      extraPadding = lib.mkForce (pkgs.image-builder.helpers.size.MiB 128);
    };
    device = {
      name = "oneplus-fajita";
      supportLevel = "best-effort";
      identity.name = "OnePlus 6T";
    };
    hardware.screen.height = 2340;
  };

  initrd.supportedFilesystems = [
    "btrfs"
    "ext4"
    "f2fs"
  ];

  /*
    blacklistedKernelModules = [
        "qcrypto"
        "ipa"
      ];
      kernelParams = [
        "clk_ignore_unused"
        "pd_ignore_unused"
        "arm64.nopauth"
        "console=ttyGS0,115200"
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
  */
}

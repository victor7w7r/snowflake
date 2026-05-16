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
in
{
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

    /*
      (import ./lib/tarball.nix {
      inherit config pkgs;
      additionalContent = bootFiles;
      })
    */
  ];

  fileSystems = {
    "/nix" = f2fs {
      label = "userdata";
      device = "/dev/disk/by-partlabel/userdata";
    };
  };

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

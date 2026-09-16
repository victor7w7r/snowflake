{ kernel, ... }:
{
  den.aspects.phone.boot.nixos =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      systemd = {
        units."systemd-boot-random-seed.service".enable = false;
        services.systemd-boot-random-seed.enable = false;
      };

      boot = {
        loader = {
          efi.canTouchEfiVariables = false;
          systemd-boot = lib.mkForce {
            enable = true;
            editor = false;
            configurationLimit = 14;
            extraFiles = {
              "EFI/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
              "EFI/poweroff.nsh" = pkgs.writeText "poweroff.nsh" "reset -s";
              "EFI/reboot.nsh" = pkgs.writeText "reboot.nsh" "reset -c";
            };
            extraEntries = {
              "poweroff.conf" = ''
                title      Apagar (Poweroff)
                efi        /EFI/tools/shell.efi
                options    -e -noexit /EFI/tools/poweroff.nsh
              '';
              "reboot.conf" = ''
                title      Reiniciar (Reboot)
                efi        /EFI/tools/shell.efi
                options    -e -noexit /EFI/tools/reboot.nsh
              '';
            };
          };
        };

        kernelPackages =
          (kernel.hosts.phone pkgs "phone" "aarch64-linux" pkgs.stdenv.hostPlatform.system)
          .phone-kernelPackages;

        kernelParams = [
          "clk_ignore_unused"
          "pd_ignore_unused"
          "arm64.nopauth"
          "console=tty0"
          "console=ttyGSM0,115200"
          "zram.num_devices=2"
          "firmware_class.path=/extra-firmware"
        ];

        blacklistedKernelModules = [
          "ipa"
          "qcrypto"
          "rpmsg_wwan_ctrl"
        ];

        initrd = {
          includeDefaultModules = false;
          availableKernelModules = [ "sd_mod" ];
          kernelModules = [
            "ath10k_core"
            "ath10k_snoc"
            "dm_mod"
            "rmi_core"
            "rtc_pm8xxx"
            "rmi_i2c"
            "libcomposite"
            "qcom-pmi8998-haptics"
            "g_ffs"
          ];

          systemd.storePaths =
            map
              (fw: {
                source = "${config.hardware.firmware}/lib/firmware/${fw}";
                target = "/extra-firmware/${fw}";
              })
              [
                "qcom/sdm845/OnePlus/enchilada/adsp.mbn"
                "qcom/sdm845/OnePlus/enchilada/cdsp.mbn"
                "qcom/sdm845/OnePlus/enchilada/ipa_fws.mbn"

                "qcom/sdm845/OnePlus/enchilada/a630_zap.mbn"
                "qcom/sdm845/OnePlus/enchilada/slpi.mbn"
                "ath10k/WCN3990/hw1.0/board-2.bin"
                "qca/crbtfw21.tlv"
                "qca/crnv21.bin"
                "qca/OnePlus/enchilada/crnv21.bin"

                "qcom/a630_sqe.fw"
                "qcom/a630_gmu.bin"
              ];
        };
      };
    };
}

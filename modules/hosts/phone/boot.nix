{ kernel, ... }:
{
  den.aspects.phone.boot.nixos =
    { pkgs, lib, ... }:
    {
      systemd = {
        units."systemd-boot-random-seed.service".enable = false;
        services.systemd-boot-random-seed.enable = false;
      };

      boot = {
        loader = {
          efi = {
            efiSysMountPoint = "/efi";
            canTouchEfiVariables = false;
          };
          systemd-boot = lib.mkForce {
            enable = true;
            editor = false;
            configurationLimit = 14;
            extraFiles = {
              "EFI/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
              "EFI/tools/poweroff.nsh" = pkgs.writeText "poweroff.nsh" "reset -s";
              "EFI/tools/reboot.nsh" = pkgs.writeText "reboot.nsh" "reset -c";
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
          "console=ttyGS0,115200"
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
            "qcom-pmi8998-haptics"
          ];
        };
      };
    };
}

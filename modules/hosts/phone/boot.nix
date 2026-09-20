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
          #"clk_ignore_unused"
          #"pd_ignore_unused"
          "console=tty0"
          "console=ttyGS0,115200"
          #"console=ttyMSM0,115200"
          "cma=256M"
          "zram.num_devices=2"
          "firmware_class.path=/extra-firmware"
        ];

        blacklistedKernelModules = [
          "ipa"
          "qcrypto"
          "g_ether"
          "rpmsg_wwan_ctrl"
        ];

        initrd = {
          includeDefaultModules = false;
          availableKernelModules = [ "sd_mod" ];
          kernelModules = [
            #"ath10k_core"
            #"ath10k_snoc"
            "dm_mod"
            "fastrpc"
            "g_ffs"
            "libcomposite"
            "qcom-pmi8998-haptics"
            "qcom_q6v5_mss"
            "qcom_q6v5_pas"
            "rmi_core"
            "rmi_i2c"
            "rtc_pm8xxx"
            "usb_f_ncm"
            "vfat"
            "nls_cp437"
            "nls_iso8859-1"
          ];

          systemd = {
            services.save-journal-on-emergency = {
              description = "Dump journalctl to EFI partition on emergency";

              wantedBy = [ "emergency.target" ];
              before = [ "emergency.service" ];

              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };

              script = ''
                MNT="/tmp/efifs"
                mkdir -p "$MNT"

                EFI_DEV="dev/disk/by-partlabel/system_a"

                if ${pkgs.util-linux}/bin/mount -t vfat "$EFI_DEV" "$MNT"; then
                  mkdir -p "$MNT/initrd-logs"
                  LOG_FILE="$MNT/initrd-logs/journal-panic-$(date +%s).log"
                  ${pkgs.systemd}/bin/journalctl -b --no-pager > "$LOG_FILE"
                  sync
                  ${pkgs.util-linux}/bin/umount "$MNT"
                fi
              '';
            };
            storePaths =
              map
                (fw: {
                  source = "${config.hardware.firmware}/lib/firmware/${fw}";
                  target = "/extra-firmware/${fw}";
                })
                [
                  "qcom/sdm845/OnePlus/enchilada/a630_zap.mbn"
                  "qcom/sdm845/OnePlus/enchilada/adsp.mbn"
                  "qcom/sdm845/OnePlus/enchilada/cdsp.mbn"
                  "qcom/sdm845/OnePlus/enchilada/ipa_fws.mbn"
                  "qcom/sdm845/OnePlus/enchilada/mba.mbn"
                  "qcom/sdm845/OnePlus/enchilada/modem.mbn"
                  "qcom/sdm845/OnePlus/enchilada/slpi.mbn"
                  "qcom/sdm845/OnePlus/enchilada/venus.mbn"
                  "qcom/sdm845/OnePlus/enchilada/wlanmdsp.mbn"
                  "ath10k/WCN3990/hw1.0/firmware-5.bin"
                  "ath10k/WCN3990/hw1.0/board-2.bin"
                  "qca/crbtfw21.tlv"
                  "qca/OnePlus/enchilada/crnv21.bin"
                  "qcom/a630_sqe.fw"
                  "qcom/a630_gmu.bin"
                ];
          };
        };
      };
    };
}

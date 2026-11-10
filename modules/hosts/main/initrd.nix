{ self, ... }: {
  den.aspects.main.initrd.nixos =
    { config, pkgs, ... }:
    {
      boot.initrd = {

        kernelModules = [
          "aesni_intel"
          "ahci"
          "apple-bce"
          "brcmfmac"
          "brcmfmac_wcc"
          "cryptd"
          "dm_crypt"
          "dm_mod"
          "dm_raid"
          "ehci-hcd"
          "encrypted_keys"
          "kvm_intel"
          "uas"
          "uhci_hcd"
          "usb_storage"
          "usbhid"
          "xhci_hcd"
          "zfs"
        ];

        services.udev.packages = [ pkgs.libfido2 ];

        systemd = {
          contents = {
            "/etc/zfs-fido/assert_param_1".source = "${self}/assets/secrets/assert_param_1";
            "/etc/zfs-fido/assert_param_2".source = "${self}/assets/secrets/assert_param_2";
            "/etc/zfs-fido/blob_1".source = "${self}/assets/secrets/blob_1";
            "/etc/zfs-fido/blob_2".source = "${self}/assets/secrets/blob_2";
          };
          extraBin = {
            fido2-assert = "${pkgs.libfido2}/bin/fido2-assert";
            fido2-token = "${pkgs.libfido2}/bin/fido2-token";
            openssl = "${pkgs.openssl}/bin/openssl";
          };
          tpm2.enable = false;
          services = {
            zfs-import-zroot.enable = false;
            zfs-import-zmini.enable = false;
            zfs-import-zstorage.enable = false;

            zfs-setimport = {
              wantedBy = [ "initrd.target" ];
              before = [
                #"rollback-zfs.service"
                "initrd-fs.target"
                "sysroot.mount"
              ];
              after = [
                "systemd-modules-load.service"
                "systemd-udev-settle.service"
                "dev-disk-by-id.device"
              ];
              wants = [ "systemd-udev-settle.service" ];
              unitConfig.DefaultDependencies = false;
              path = [
                config.boot.zfs.package
                pkgs.util-linux
                pkgs.systemd
                pkgs.coreutils
              ];
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
              };
              script = ''
                echo "Toca la llave para desbloquear los dispositivos..." > /dev/console
                for i in $(seq 1 60); do
                  for dev in $(fido2-token -L 2>/dev/null | grep -o '^/dev/hidraw[0-9]*'); do
                    for n in 1 2; do
                      H=$(fido2-assert -G -h -i /etc/zfs-fido/assert_param_$n "$dev" 2>/dev/null | tail -n1)
                      [ -n "$H" ] || continue
                      export H
                      P=$(openssl enc -d -aes-256-cbc -pbkdf2 -base64 -A -pass env:H -in /etc/zfs-fido/blob_$n 2>/dev/null) || continue
                      [ -n "$P" ] || continue
                      printf '%s' "$P" > /tmp/secret.key

                      zpool import -f -N -a -d /dev/disk/by-id
                      zfs rollback -r zroot/local/root@empty
                  
                      cat /tmp/secret.key | zfs load-key zmini/safe/persist
                      cat /tmp/secret.key | zfs load-key zmini/safe/swap
                      cat /tmp/secret.key | zfs load-key zstorage/safe/storage
                  
                      rm -f /tmp/secret.key
                      exit 0
                    done
                  done
                  sleep 1
                done
                echo "No se pudo desbloquear ZFS" > /dev/console
                exit 1
              '';
            };
          };
        };
      };
    };
}

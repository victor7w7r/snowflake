{ inputs, ... }: {
  den.aspects.phone.services.usb-gadget.nixos =
    {
      lib,
      pkgs,
      self',
      ...
    }:
    {
      boot.blacklistedKernelModules = [ "g_ether" ];

      systemd.services = {
          "serial-getty@ttyGS0" = {
            enable = true;
            wantedBy = [ "multi-user.target" ];
            requires = [ "usb-gadget-bind.service" ];
            after = [ "usb-gadget-bind.service" ];
          };

          adbd = {
            description = "adb daemon";
            wantedBy = [ "multi-user.target" ];
            requires = [ "usb-gadget.service" ];
            after = [ "usb-gadget.service" ];
            serviceConfig = {
              Restart = "always";
              ExecStart =
                "${inputs.mobile-nixos}/overlay"
                |> (
                  route:
                  pkgs.callPackage "${route}/adbd" {
                    libhybris = pkgs.callPackage "${route}/libhybris" {
                      android-headers = pkgs.callPackage "${route}/android-headers" { };
                    };
                  }
                )
                |> (adbd: "${adbd}/bin/adbd");
            };
          };


          usb-gadget = {
            unitConfig.DefaultDependencies = false;
            requires = [
              "sys-kernel-config.mount"
              "modprobe@libcomposite.service"
            ];
            after = [
              "systemd-modules-load.service"
              "sys-kernel-config.mount"
              "modprobe@libcomposite.service"
            ];
            wantedBy = [ "basic.target" ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            restartIfChanged = false;

            script = ''
              GADGET="/sys/kernel/config/usb_gadget/g1"

              # The initrd may leave g_ether or an old configfs gadget bound.
              ${pkgs.kmod}/bin/modprobe -r g_ether 2>/dev/null || true
              if [ -f "$GADGET/UDC" ]; then
                echo "" > "$GADGET/UDC" 2>/dev/null || true
              fi
              umount /dev/usb-ffs/adb 2>/dev/null || true
              for link in "$GADGET/configs/c.1/"*; do
                [ -e "$link" ] || continue
                rm -f "$link"
              done
              for entry in "$GADGET/functions/"*; do
                [ -e "$entry" ] || continue
                rmdir "$entry" 2>/dev/null || true
              done

              mkdir -p $GADGET
              echo "0x1d6b" > $GADGET/idVendor
              echo "0x0104" > $GADGET/idProduct

              mkdir -p $GADGET/strings/0x409
              echo "NixOS" > $GADGET/strings/0x409/manufacturer
              echo "OnePlus 6" > $GADGET/strings/0x409/product
              echo "NixOS" > $GADGET/strings/0x409/serialnumber

              mkdir -p $GADGET/functions/ncm.usb0
              mkdir -p $GADGET/functions/ffs.adb
              mkdir -p $GADGET/functions/acm.usb0

              mkdir -p /dev/usb-ffs/adb
              if ! grep -qs " /dev/usb-ffs/adb " /proc/mounts; then
                mount -t functionfs adb /dev/usb-ffs/adb
              fi

              mkdir -p $GADGET/configs/c.1
              mkdir -p $GADGET/configs/c.1/strings/0x409
              echo "USB Net + ADB + Serial" > $GADGET/configs/c.1/strings/0x409/configuration

              ln -s $GADGET/functions/ncm.usb0 $GADGET/configs/c.1/
              ln -s $GADGET/functions/ffs.adb $GADGET/configs/c.1/
              ln -s $GADGET/functions/acm.usb0 $GADGET/configs/c.1/

            '';
          };

          usb-gadget-bind = {
            description = "Bind USB gadget after FunctionFS services are ready";
            wantedBy = [ "multi-user.target" ];
            requires = [
              "usb-gadget.service"
              "adbd.service"
            ];
            after = [
              "usb-gadget.service"
              "adbd.service"
            ];
            before = [
              "serial-getty@ttyGS0.service"
              "usb-gadget-unudhcpd.service"
            ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };
            script = ''
              GADGET="/sys/kernel/config/usb_gadget/g1"
              udc=""
              attempts=0

              while [ -z "$udc" ] && [ "$attempts" -lt 30 ]; do
                udc=$(ls /sys/class/udc | head -n 1)
                if [ -z "$udc" ]; then
                  attempts=$((attempts + 1))
                  sleep 1
                fi
              done

              if [ -z "$udc" ]; then
                echo "No USB device controller found" >&2
                exit 1
              fi

              current_udc=$(cat "$GADGET/UDC")
              if [ "$current_udc" != "$udc" ]; then
                echo "$udc" > "$GADGET/UDC"
              fi
            '';
          };

          usb-gadget-unudhcpd = {
            wantedBy = [ "multi-user.target" ];
            requires = [ "usb-gadget-bind.service" ];
            after = [ "usb-gadget-bind.service" ];
            description = "DHCP server for USB Gadget";
            serviceConfig.ExecStart = "${lib.getExe self'.packages.unudhcpd} -i usb0 -s 172.16.42.1 -c 172.16.42.2";
          };
        };
    };
}

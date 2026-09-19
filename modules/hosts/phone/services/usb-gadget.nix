{ inputs, ... }: {
  den.aspects.phone.services.usb-gadget.nixos =
    { pkgs, ... }:
    {
      systemd = {
        network = {
          enable = true;
          "10-usb0" = {
            matchConfig.Name = "usb0";
            networkConfig = {
              Address = "172.16.42.1/24";
              ConfigureWithoutCarrier = true;
              IPv6AcceptRA = false;
            };
            linkConfig.RequiredForOnline = "no";
          };
        };

        services = {
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
            after = [
              "systemd-modules-load.service"
              "sys-kernel-config.mount"
            ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
              ExecStop = pkgs.writeShellScript "usb-gadget-down" ''
                G=/sys/kernel/config/usb_gadget/g1
                [ -d "$G" ] && echo "" > "$G/UDC" || true
              '';
              ExecStart = pkgs.writeShellScript "usb-gadget" ''
                set -eu
                G=/sys/kernel/config/usb_gadget/g1

                if [ -d "$G" ]; then
                  echo "" > "$G/UDC" 2>/dev/null || true
                  for l in "$G"/configs/*/ncm.usb0 "$G"/configs/*/rndis.usb0; do
                    [ -e "$l" ] && rm -f "$l" || true
                  done
                  rmdir "$G"/configs/*/strings/* 2>/dev/null || true
                  rmdir "$G"/configs/* 2>/dev/null || true
                  rmdir "$G"/functions/* 2>/dev/null || true
                  rmdir "$G"/strings/* 2>/dev/null || true
                  rmdir "$G" || true
                fi

                mkdir -p $G
                echo 0x18d1 > "$G/idVendor"
                echo 0xd001 > "$G/idProduct"
                echo 0x0200 > "$G/bcdUSB"
                echo 0x0100 > "$G/bcdDevice"

                mkdir -p "$G/strings/0x409"
                echo "NixOS" > $G/strings/0x409/manufacturer
                echo "OnePlus 6" > $G/strings/0x409/product
                echo "phone-d4g3" > $G/strings/0x409/serialnumber

                mkdir -p "$G/configs/c.1/strings/0x409"
                echo "USB Net + ADB + Serial" > "$G/configs/c.1/strings/0x409/configuration"
                echo 250 > "$G/configs/c.1/MaxPower"

                mkdir -p "$G/functions/ncm.usb0"
                echo "02:22:82:ff:ff:11" > "$G/functions/ncm.usb0/dev_addr"
                echo "02:22:82:ff:ff:22" > "$G/functions/ncm.usb0/host_addr"
                ln -s "$G/functions/ncm.usb0" "$G/configs/c.1/ncm.usb0"

                mkdir -p "$G/functions/acm.usb0"
                ln -s "$G/functions/acm.usb0" "$G/configs/c.1/acm.usb0"

                mkdir -p "$G/functions/ffs.adb"
                ln -s "$G/functions/ffs.adb" "$G/configs/c.1/ffs.adb"

                mkdir -p /dev/usb-ffs/adb
                if ! grep -qs " /dev/usb-ffs/adb " /proc/mounts; then
                  mount -t functionfs adb /dev/usb-ffs/adb
                fi

                UDC=$(ls /sys/class/udc | head -n1)
                echo "$UDC" > "$G/UDC" || true
              '';
            };
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
        };
      };
    };
}

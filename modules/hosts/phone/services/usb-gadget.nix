{ inputs, ... }: {
  den.aspects.phone.services.usb-gadget.nixos =
    {
      lib,
      pkgs,
      self',
      ...
    }:
    {
      environment.etc = {
        "usb-moded/nixos-settings.ini".source =
          (pkgs.formats.ini { }).generate "usb-moded-nixos-settings.ini"
            {
              network.ip = "172.16.42.1";
              configfs = {
                gadget_base_directory = "/sys/kernel/config/usb_gadget/g1";
                gadget_conf_directory = "configs/c.1";
              };
            };
      }
      // (lib.mapAttrs'
        (
          name: value:
          lib.nameValuePair "usb-moded/dyn-modes/${name}.ini" {
            source = (pkgs.formats.ini { }).generate "usb-moded-${name}-mode.ini" value;
          }
        )
        {
          developer_mode = {
            mode = {
              name = "developer_mode";
              module = "none";
              network = 1;
              appsync = 1;
            };
            options = {
              sysfs_value = "ncm.usb0";
              dhcp_server = 0;
            };
          };
        }
      )
      // (lib.mapAttrs'
        (
          name: value:
          lib.nameValuePair "usb-moded/run/${name}.ini" {
            source = (pkgs.formats.ini { }).generate "usb-moded-${name}-run.ini" value;
          }
        )
        {
          developer-unudhcpd.info = {
            systemd = 1;
            name = "usb-gadget-unudhcpd.service";
            mode = "developer_mode";
            post = 1;
          };
        }
      );

      services.dbus.packages = [ self'.packages.usb-moded ];

      systemd = {
        packages = [ self'.packages.usb-moded ];
        services = {
          "serial-getty@ttyGS0" = {
            enable = true;
            wantedBy = [ "multi-user.target" ];
            requires = [ "usb-gadget.service" ];
            after = [ "usb-gadget.service" ];
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

          usb-moded = {
            wantedBy = [ "basic.target" ];
            after = [ "usb-gadget.service" ];

            path = [ pkgs.unixtools.ifconfig ];

            environment = {
              USB_MODED_ARGS = "-r";
              USB_MODED_HW_ADAPTATION_ARGS = "";
            };
          };

          usb-moded-turn-off-rescue-mode = {
            description = "Turn off usb-moded rescue mode";

            wantedBy = [ "graphical.target" ];
            after = [
              "graphical.target"
              "usb-moded.service"
            ];

            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
              ExecStart = [
                "busctl emit /com/nokia/startup/signal com.nokia.startup.signal init_done"
                ''
                  -busctl call com.meego.usb_moded /com/meego/usb_moded com.meego.usb_moded \
                    set_mode s "charging_only"
                ''
              ];
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
              mount -t functionfs adb /dev/usb-ffs/adb

              mkdir -p $GADGET/configs/c.1
              mkdir -p $GADGET/configs/c.1/strings/0x409
              echo "USB Net + ADB + Serial" > $GADGET/configs/c.1/strings/0x409/configuration

              ln -s $GADGET/functions/ncm.usb0 $GADGET/configs/c.1/
              ln -s $GADGET/functions/ffs.adb $GADGET/configs/c.1/
              ln -s $GADGET/functions/acm.usb0 $GADGET/configs/c.1/

              udc=$(ls /sys/class/udc | head -1)
              echo "$udc" > $GADGET/UDC
            '';
          };

          usb-gadget-unudhcpd = {
            description = "DHCP server for USB Gadget";
            serviceConfig.ExecStart = "${lib.getExe self'.packages.unudhcpd} -i usb0 -s 172.16.42.1 -c 172.16.42.2";
          };
        };
      };
    };
}

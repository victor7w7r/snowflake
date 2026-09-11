{
  den,
  hosts,
  kernel,
  inputs,
  self,
  tarball,
  ...
}:
{
  flake-file.inputs = {
    vanilla-mobile-nixos.url = "github:vanilla-mobile-nixos/vanilla-mobile-nixos";
    disko-mobile = {
      url = "github:JuneStepp/disko/mobile";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.phone.common = {
    includes = with den.aspects; [
      (tarball.lib.call { })
      (hosts.lib.zram {
        value = "8G";
        memoryPercent = 100;
      })
      audio._
      cli._
      dev.ccache
      #dev.zed
      dev.tools
      disks
      gui._
      misc.comm
      misc.fetch
      #zen._

      phone._

      #android
      bluetooth
      emulation
      firewall
      games
      #kitty
      #libvirt
      plasma._
      remote
      root
      tools
      victor7w7r
      #virt
      #waydroid
    ];

    nixos =
      {
        config,
        inputs',
        self',
        pkgs,
        lib,
        ...
      }:
      {
        imports = [ inputs.vanilla-mobile-nixos.nixosModules.vanilla-mobile ];

        vanilla-mobile = {
          #usb-gadget.enable = lib.mkDefault true;
          powerManagement = {
            enable = lib.mkDefault true;
            sleepInhibitors.enableDefault = lib.mkDefault true;
          };

          alsa-ucm-conf = {
            enable = true;
            package = inputs'.vanilla-mobile-nixos.packages.alsa-ucm-conf-sdm845;
          };

          plymouth = {
            mobileTweaks.enable = lib.mkDefault false;
            unl0krSupport.enable = lib.mkDefault false;
          };

          deviceInfo = {
            name = "OnePlus 6";
            manufacturer = "OnePlus";
          };
        };

        nixpkgs.config.allowUnfreePackages = [ "oneplus-sdm845-firmware" ];

        powerManagement.cpuFreqGovernor = "schedutil";

        nix.settings.max-jobs = lib.mkDefault 2;

        environment = {
          systemPackages = [ self'.packages.oneplus-sdm845-firmware ];
          persistence."/nix/persist" = {
            directories = lib.mkAfter [ "/var/lib/ModemManager" ];
            users = {
              "victor7w7r".directories = [ ".cache" ];
              root.directories = [ ".cache" ];
            };
          };
          enableAllTerminfo = true;
        };

        boot = {
          kernelPackages =
            (kernel.hosts.phone pkgs "phone" "aarch64-linux" pkgs.stdenv.hostPlatform.system)
            .phone-kernelPackages;

          kernelParams = [
            "console=tty0"
            "zram.num_devices=2"
            "firmware_class.path=/extra-firmware"
          ];
          blacklistedKernelModules = [ "ipa" ];
          loader = {
            efi.canTouchEfiVariables = false;
            systemd-boot = lib.mkForce {
              enable = true;
              editor = false;
              configurationLimit = 20;
              extraFiles = {
                "EFI/uefi.efi" = "${self}/assets/sdm845/uefi.img";
                "EFI/shell.efi" = "${pkgs.edk2-uefi-shell}/shell.efi";
                "EFI/tools/poweroff.nsh" = pkgs.writeText "poweroff.nsh" "reset -s";
                "EFI/tools/reboot.nsh" = pkgs.writeText "reboot.nsh" "reset -c";
              };
              extraEntries = {
                "uefi.conf" = ''
                  title      UEFI
                  efi        /EFI/uefi.efi
                '';
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
        };

        hardware = {
          firmwareCompression = lib.mkForce "zstd";
          firmware = [ self'.packages.oneplus-sdm845-firmware ];
          sensor.iio.enable = true;
          deviceTree.enable = true;
        };

        systemd = {
          sockets.sshd.socketConfig.FreeBind = lib.mkIf config.services.openssh.startWhenNeeded true;
          units."systemd-boot-random-seed.service".enable = false;
          tmpfiles.rules = [
            "d /readonly/vendor/firmware_mnt/image 0755 root root -"
            "L+ /readonly/vendor/firmware_mnt/image/wlanmdsp.mbn - - - - /lib/firmware/wlanmdsp.mbn"
            "L+ /readonly/vendor/firmware/wlanmdsp.mbn - - - - /lib/firmware/wlanmdsp.mbn"
            "d /var/lib/tqftpserv 0777 root root -"
          ];
          services = {
            systemd-boot-random-seed.enable = false;
            usb-moded-turn-off-rescue-mode.enable = false;

            ModemManager = {
              after = [ "msm-modem-uim-selection.service" ];
              requires = [ "msm-modem-uim-selection.service" ];
              serviceConfig.ExecStart = lib.mkForce [
                ""
                "${pkgs.modemmanager}/bin/ModemManager --test-quick-suspend-resume"
              ];
              iio-sensor-proxy.serviceConfig.TimeoutStopSec = 3;
            };
          };
        };
      };
  };
}

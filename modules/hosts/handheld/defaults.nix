{ den, lib, ... }:
{
  den.aspects.handheld = {
    includes = [ ];

    nixos =
      { pkgs, user, ... }:
      {
        hardware = {
          amdgpu.opencl.enable = true;
          xone.enable = true;
        };

        environment = {
          systemPackages = with pkgs; [
            asusctl
            amdgpu_top
            brightnessctl
            kdePackages.plasma-thunderbolt
            radeontop
            ryzenadj
            tbtools
            qjoypad
            thunderbolt
          ];
          persistence."/nix/persist" = {
            directories = lib.mkAfter [
              "/etc/asusd"
              "/etc/hhd"
            ];
            users."${user}".directories = [ ".config/rog" ];
          };
        };

        systemd.services.supergfxd.path = with pkgs; [
          kmod
          pciutils
        ];

        programs.rog-control-center = {
          enable = true;
          autoStart = true;
        };

        fprintd = {
          enable = true;
          /*
            package = pkgs.fprintd.override {
            libfprint = pkgs.callPackage ./custom/focaltech.nix { };
            };
          */
        };

        udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="pci", DRIVER=="amdgpu", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/%p/power_dpm_force_performance_level /sys/%p/pp_od_clk_voltage"
          SUBSYSTEM=="usb", ATTR{idVendor}=="2808", ATTR{idProduct}=="a753", MODE="0660", GROUP="input"
        '';
      };
  };
}

{ lib, ... }:
{
  handheld.hardware.nixos =
    { pkgs, ... }:
    let
      pscript = pkgs.writeScriptBin "charge-upto" ''
        #!${pkgs.bash}/bin/bash
        echo ''${1:-100} > /sys/class/power_supply/BAT?/charge_control_end_threshold
      '';
    in
    {
      environment.systemPackages = [ pscript ];

      hardware = {
        amdgpu = {
          opencl.enable = true;
          initrd.enable = true;
        };
        cpu.amd.updateMicrocode = true;
        #xone.enable = true;
      };

      systemd.services.battery-charge-threshold = {
        wantedBy = [
          "local-fs.target"
          "suspend.target"
          "suspend-then-hibernate.target"
          "hibernate.target"
        ];
        after = [
          "local-fs.target"
          "suspend.target"
          "suspend-then-hibernate.target"
          "hibernate.target"
        ];
        startLimitBurst = 5;
        startLimitIntervalSec = 1;
        serviceConfig = {
          Type = "oneshot";
          Restart = "on-failure";
          ExecStart = "${pkgs.runtimeShell} -c 'echo 85 > /sys/class/power_supply/BAT?/charge_control_end_threshold'";
        };
      };

      services = {
        xserver.videoDrivers = lib.mkDefault [ "modesetting" ];
        udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="pci", DRIVER=="amdgpu", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/%p/power_dpm_force_performance_level /sys/%p/pp_od_clk_voltage"
          SUBSYSTEM=="usb", ATTR{idVendor}=="2808", ATTR{idProduct}=="a753", MODE="0660", GROUP="input"
        '';
        fprintd = {
          enable = true;
          /*
            package = pkgs.fprintd.override {
              libfprint = pkgs.callPackage ./custom/focaltech.nix { };
              };
          */
        };
      };
    };
}

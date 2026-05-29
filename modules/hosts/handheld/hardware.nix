{
  handheld.hardware.nixos =
    { pkgs, ... }:
    {
      hardware = {
        amdgpu.opencl.enable = true;
        xone.enable = true;
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
}

{ lib, hosts-attrs, ... }:
{
  den.aspects.gui.provides = lib.genAttrs hosts-attrs.graphic (_: {
    nixos.services.displayManager.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad = {
        naturalScrolling = true;
        accelProfile = "flat";
        tapping = true;
        accelSpeed = "0.75";
      };
    };
  });
}

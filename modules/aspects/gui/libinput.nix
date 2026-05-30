{
  den.aspects.gui.provides.libinput.nixos.services.displayManager.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad = {
      naturalScrolling = true;
      accelProfile = "flat";
      tapping = true;
      accelSpeed = "0.75";
    };
  };
}

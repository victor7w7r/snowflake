{ lib, ... }:
{
  den.aspects.gui.default.nixos =
    { pkgs, user, ... }:
    {
      users.groups.video.members = [ user ];
      services = {
        gvfs.enable = true;
        xserver.enable = lib.mkForce true;
        displayManager.libinput = {
          enable = true;
          mouse.accelProfile = "flat";
          touchpad = {
            naturalScrolling = true;
            accelProfile = "flat";
            tapping = true;
            accelSpeed = "0.75";
          };
        };
      };
      hardware.uinput.enable = true;
      environment.systemPackages = with pkgs; [
        evemu
        libinput
        keyd
      ];
    };
}

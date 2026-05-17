{ pkgs, host, ... }:
{
  xdg = {
    portal = {
      enable = true;
      extraPortals =
        with pkgs;
        (
          if host != "v7w7r-fajita" && host != "v7w7r-opizero2w" then
            [
              kdePackages.xdg-desktop-portal-kde
              xdg-desktop-portal-gtk
            ]
          else
            [ ]
        );
      xdgOpenUsePortal = true;
    };
    mime.enable = true;
    autostart.enable = true;
    menus.enable = true;
    sounds.enable = true;
    icons.enable = true;
    terminal-exec.enable = true;
  };
}

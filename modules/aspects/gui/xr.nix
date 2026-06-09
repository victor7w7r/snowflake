{
  den.aspects.gui.xr.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        breezy-desktop
        xrlinux
      ];

      services.udev.packages = with pkgs; [ xrlinux ];
      boot.kernelModules = [ "uinput" ];

      systemd.user.services.xr-driver = {
        description = "XR user-space driver (Rayneo / XREAL / Viture / Rokid)";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStartPre = "${pkgs.coreutils}/bin/install -Dm644 ${../../../../dotfiles/default/xr_driver/config.ini} %h/.config/xr_driver/config.ini";
          ExecStart = "${pkgs.xrlinux}/bin/xrDriver";
          Restart = "always";
          RestartSec = 2;
        };
      };
    };
}

{
  lib,
  pkgs,
  ...
}:
{
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
    "/share/zsh"
  ];

  systemd.services.sddm.environment = {
    QT_IM_MODULE = "qtvirtualkeyboard";
    QT_VIRTUALKEYBOARD_DESKTOP_DISABLE = "0";
  };

  environment.etc."sddm.conf.d/virtual-keyboard.conf".text = ''
    [General]
    InputMethod=qtvirtualkeyboard
  '';

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      subpixel.rgba = "rgb";
    };
  };

  services = {
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = false;
        package = lib.mkForce pkgs.kdePackages.sddm;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        settings = {
          General = {
            DisplayServer = "wayland";
            GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
            InputMethod = "qtvirtualkeyboard";
          };
          Theme = {
            theme = "sddm-astronaut-theme";
            ThemeDir = "/run/current-system/sw/share/sddm/themes";
            FacesDir = "/var/lib/AccountsService/icons";
            Font = "Ubuntu";
            EnableAvatars = true;
            DisableAvatarsThreshold = 7;
          };
          Wayland = {
            CompositorCommand = "${pkgs.kdePackages.kwin}/bin/kwin_wayland --no-lockscreen --inputmethod maliit-keyboard";
            EnableHiDPI = true;
          };
          Users = {
            DefaultPath = "/run/current-system/sw/bin";
            HideShells = "";
            HideUsers = "";
            MaximumUid = 60513;
            MinimumUid = 1000;
            RememberLastSession = true;
            RememberLastUser = true;
            ReuseSession = false;
          };
        };
        theme = "sddm-astronaut-theme";
      };
    };
  };
}

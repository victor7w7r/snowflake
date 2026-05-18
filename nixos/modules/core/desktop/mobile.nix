{ pkgs, lib, ... }:
let
  ini = pkgs.formats.ini { };
in
{
  /*
    environment.etc."xdg/kdeglobals".source = ini.generate "kdeglobals" {
      KDE.LookAndFeelPackage = "org.kde.plasma.phone";
    };
    environment.etc."xdg/kwinrc".source = ini.generate "kwinrc" {
      Wayland."InputMethod[$e]" =
        "/run/current-system/sw/share/applications/com.github.maliit.keyboard.desktop";
      Wayland.VirtualKeyboardEnabled = "true";
      "org.kde.kdecoration2".NoPlugin = "true";
      };
  */

  environment = {
    plasma6.excludePackages = with pkgs; [
      kdePackages.elisa
      kdePackages.khelpcenter
      kdePackages.kate
    ];
    systemPackages = with pkgs; [
      kdePackages.ark
      kdePackages.baloo-widgets
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.ffmpegthumbs
      kdePackages.filelight
      kdePackages.gwenview
      kdePackages.isoimagewriter
      kdePackages.kamoso
      kdePackages.kbackup
      kdePackages.kcalc
      kdePackages.kcachegrind
      kdePackages.kcharselect
      kdePackages.kcmutils
      kdePackages.kcolorchooser
      kdePackages.kcron
      kdePackages.kdegraphics-thumbnailers
      kdePackages.kdenetwork-filesharing
      kdePackages.kdf
      kdePackages.kfind
      kdePackages.kget
      kdePackages.kgpg
      kdePackages.kjournald
      kdePackages.kmix
      kdePackages.koko
      kdePackages.kompare
      kdePackages.konsole
      kdePackages.kontrast
      kdePackages.krdc
      kdePackages.krdp
      kdePackages.ktorrent
      kdePackages.ksystemlog
      kdePackages.kwallet
      kdePackages.kwallet-pam
      kdePackages.okular
      kdePackages.plasma-workspace
      kdePackages.plasma-desktop
      kdePackages.plasma-integration
      kdePackages.partitionmanager
      kdePackages.polkit-qt-1
      kdePackages.polkit-kde-agent-1
      kdePackages.qtmultimedia
      kdePackages.qtstyleplugin-kvantum
      kdePackages.sddm-kcm
      kdePackages.sweeper
      kdePackages.yakuake
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
      kdePackages.qtquick3d
      kdePackages.qtvirtualkeyboard
      #heaptrack
      ffmpegthumbnailer
      graphviz
      icoextract
      icoutils
      kdiff3
      kdiskmark
      krename
      #krita
      krusader
      maliit-keyboard
      onboard
      qpwgraph
      #okteta
      pinentry-qt
      systemdgenie
      ulauncher
    ];
  };

  services = {
    desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        #settings.General.DisplayServer = "wayland";
      };
      sessionPackages = with pkgs; [
        kdePackages.plasma-mobile
      ];
      defaultSession = "plasma-mobile";
      #defaultSession = "plasma";
      autoLogin = {
        enable = true;
        user = "victor7w7r";
      };
    };
  };
}

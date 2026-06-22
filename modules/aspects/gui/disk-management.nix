{ den, ... }:
{
  den.aspects.gui.disk-management = {
    includes = [
      (den.batteries.insecure [
        "qtwebengine-5.15.19"
        "ventoy-qt5-1.1.10"
        "ventoy-qt5-1.1.12"
        "electron-39.8.10"
      ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          btrfs-assistant
          ddrescueview
          gparted
          qdiskinfo
          snapper-gui
          testdisk-qt
          woeusb-ng
          ventoy-full-qt
          #https://aur.archlinux.org/packages/repair-usb-disc-gtk4
        ];
      };
  };
}

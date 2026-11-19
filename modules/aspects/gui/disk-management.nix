{ __findFile, ... }:
{
  den.aspects.gui.disk-management = {
    includes = [
      (<den/insecure> [
        "electron-40.10.5"
      ])
    ];

    provides.to-users.homeManager =
      {
        isPhone,
        pkgs,
        self',
        ...
      }:
      {
        home.packages =
          with pkgs;
          [
            gparted
            qdiskinfo
          ]
          ++ (lib.optionals (!isPhone) [
            self'.packages.repair-usb-disc-gtk4
            btrfs-assistant
            snapper-gui
            testdisk-qt
            ddrescueview
            woeusb-ng # DEP python3.14-wxpython
          ]);
      };
  };
}

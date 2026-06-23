{
  den.aspects.android = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          adbfs-rootless
          adb-sync
          androguard
          android-file-transfer
          android-tools
          gnirehtet
          go-mtpfs
          qtscrcpy
          payload-dumper-go
          spytrap-adb
          scrcpy
          universal-android-debloater
        ];
      };

    nixos =
      { pkgs, self', ... }:
      let
        xiaomiVendor = "2717";
        oneplusVendor = "18d1";
      in
      {
        services.udev.extraRules = ''
          SUBSYSTEM=="usb", ATTR{idVendor}=="${xiaomiVendor}", ATTR{idProduct}=="ff40", SYMLINK+="android_adb"
          SUBSYSTEM=="usb", ATTR{idVendor}=="${xiaomiVendor}", ATTR{idProduct}=="ff40", SYMLINK+="android_fastboot"
          SUBSYSTEM=="usb", ATTR{idVendor}=="${oneplusVendor}", ATTR{idProduct}=="d00d", SYMLINK+="android_adb"
          SUBSYSTEM=="usb", ATTR{idVendor}=="${oneplusVendor}", ATTR{idProduct}=="d00d", SYMLINK+="android_fastboot"
        '';

        environment.systemPackages = with pkgs; [
          adbtuifm
          simple-mtpfs
          self'.packages.adb-shell
          self'.packages.apkinspector
          self'.packages.appmanager
          self'.packages.adebar
          self'.packages.aya
          self'.packages.better-adb-sync
          self'.packages.logcat-color3
          self'.packages.zilch
          self'.packages.scrcpy-wrapper
          #https://github.com/Aldeshov/ADBFileExplorer
        ];
      };
  };
}

{
  den.aspects.android = {
    os =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          adbfs-rootless
          androguard
          android-file-transfer
          android-tools
          gnirehtet
          go-mtpfs
          payload-dumper-go
          qtscrcpy
          scrcpy
          spytrap-adb
          universal-android-debloater
        ];
      };

    nixos =
      {
        pkgs,
        self',
        isX86,
        ...
      }:
      {
        services.udev.extraRules =
          {
            xiaomi = "2717";
            oneplus = "18d1";
          }
          |> (vendors: ''
            SUBSYSTEM=="usb", ATTR{idVendor}=="${vendors.xiaomi}", ATTR{idProduct}=="ff40", SYMLINK+="android_adb"
            SUBSYSTEM=="usb", ATTR{idVendor}=="${vendors.xiaomi}", ATTR{idProduct}=="ff40", SYMLINK+="android_fastboot"
            SUBSYSTEM=="usb", ATTR{idVendor}=="${vendors.oneplus}", ATTR{idProduct}=="d00d", SYMLINK+="android_adb"
            SUBSYSTEM=="usb", ATTR{idVendor}=="${vendors.oneplus}", ATTR{idProduct}=="d00d", SYMLINK+="android_fastboot"
          '');

        environment.systemPackages =
          with pkgs;
          with self'.packages;
          [
            #adb-shell
            (python3.withPackages (ps: with ps; [ apkinspector ]))
            adbtuifm
            adebar
            app-manager
            audiosource
            better-adb-sync
            logcat-color3
            scrcpy-wrapper
            zilch
          ]
          ++ (lib.optionals isX86 [ aya ]);
      };
  };
}

{
  den.aspects.plasma.mobile = { user, ... }: {
    nixos =
      {
        lib,
        isPhone,
        pkgs,
        self',
        ...
      }:
      lib.optionalAttrs isPhone {
        services.xserver.enable = true;
        environment = {
          persistence."/nix/persist".users."${user.name}" = {
            directories = [ ".config/plasma-mobile" ];
            #files = [ ".config/plasmamobilerc" ];
          };
          plasma6.excludePackages = with pkgs.kdePackages; [
            kcalc
            systemsettings
          ];
          systemPackages =
            with pkgs.kdePackages;
            with self'.packages;
            [
              angelfish
              audiotube
              calindori
              elisa
              #index-fm
              kalk
              kclock
              koko
              krecorder
              plasma-camera
              plasma-dialer
              plasma-mobile
              plasma-phonebook
              plasma-settings
              plasmatube
              qmlkonsole
              spacebar
            ];
        };
      };

    provides.to-users.homeManager =
      {
        lib,
        isPhone,
        ...
      }:
      lib.optionalAttrs isPhone {
        xdg.configFile."plasmamobilerc".text =
          lib.generators.toINI
            {
              mkKeyValue = lib.generators.mkKeyValueDefault { } "=";
            }
            {
              General = {
                actionDrawerTopLeftMode = "0";
                actionDrawerTopRightMode = "1";
                dateInStatusBar = "false";
                gesturePanelEnabled = "false";
                showBatteryPercentage = "true";
                statusBarScaleFactor = "1";
                vibrationDuration = "10";
                animationsEnabled = "false";
                navigationPanelEnabled = "false";
              };
              InitialStart.wizardRun = "true";
              QuickSettings = {
                quickSettingsColumns = "3";
                disabledQuickSettings = builtins.concatStringsSep "," [
                  "org.kde.plasma.quicksetting.nightcolor"
                  "org.kde.plasma.quicksetting.kscreenosd"
                  "org.kde.plasma.quicksetting.settingsapp"
                  "org.kde.plasma.quicksetting.battery"
                  "org.kde.plasma.quicksetting.powermenu"
                ];
                enabledQuickSettings = builtins.concatStringsSep "," [
                  "org.kde.plasma.quicksetting.wifi"
                  "org.kde.plasma.quicksetting.bluetooth"
                  "org.kde.plasma.quicksetting.mobiledata"
                  "org.kde.plasma.quicksetting.flashlight"
                  "org.kde.plasma.quicksetting.screenrotation"
                  "org.kde.plasma.quicksetting.airplanemode"
                  "org.kde.plasma.quicksetting.hotspot"
                  "org.kde.plasma.quicksetting.donotdisturb"
                  "org.kde.plasma.quicksetting.audio"
                  "org.kde.plasma.quicksetting.caffeine"
                  "org.kde.plasma.quicksetting.autohidepanels"
                  "org.kde.plasma.quicksetting.docked"
                  "org.kde.plasma.quicksetting.waydroid"
                  "org.kde.plasma.quicksetting.record"
                  "org.kde.plasma.quicksetting.screenshot"
                  "org.kde.plasma.quicksetting.keyboardtoggle"
                ];
              };
            };
      };
  };
}

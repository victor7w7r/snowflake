{ appimageTools, pkgs }:

appimageTools.wrapType2 (attrs: {
  pname = "apkstudio";
  version = "6.3.0";

  src = pkgs.fetchurl {
    url = "https://github.com/vaibhavpandeyvpz/apkstudio/releases/download/v6.3.0/ApkStudio-v6.3.0-x86_64.AppImage";
    sha256 = "sha256-LHzoyxobE4RovY2haQ7COhhCIgXcB6MRuOwWoijvjfY=";
  };

  extraPkgs =
    pkgs: with pkgs; [
      apktool
      android-tools
    ];

  extraInstallCommands =
    appimageTools.extractType2 {
      pname = "apkstudio";
      version = "6.3.0";
      src = pkgs.fetchurl {
        url = "https://github.com/vaibhavpandeyvpz/apkstudio/releases/download/v6.3.0/ApkStudio-v6.3.0-x86_64.AppImage";
        sha256 = "sha256-LHzoyxobE4RovY2haQ7COhhCIgXcB6MRuOwWoijvjfY=";
      };
    }
    |> (contents: ''
      mkdir -p $out/share/applications
      cp ${
        pkgs.makeDesktopItem {
          name = "apkstudio";
          exec = "apkstudio";
          icon = "apkstudio";
          comment = "IDE for decompiling, editing & recompiling Android APKs";
          desktopName = "APK Studio";
          genericName = "APK Reverse Engineering IDE";
          categories = [
            "Development"
            "Utility"
          ];
        }
      }/share/applications/* $out/share/applications/

      mkdir -p $out/share/icons/hicolor/512x512/apps
      if [ -f ${contents}/apkstudio.png ]; then
        cp ${contents}/apkstudio.png $out/share/icons/hicolor/512x512/apps/apkstudio.png
      elif [ -f ${contents}/.DirIcon ]; then
        cp ${contents}/.DirIcon $out/share/icons/hicolor/512x512/apps/apkstudio.png
      fi
    '');
})

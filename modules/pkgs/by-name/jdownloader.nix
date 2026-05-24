{
  pkgs,
  stdenvNoCC,
  lib,
}:
let
  icon = pkgs.fetchurl {
    url = "https://jdownloader.org/_media/vote/trazo.png";
    sha256 = "3ebab992e7dd04ffcb6c30fee1a7e2b43f3537cb2b22124b30325d25bffdac29";
  };

  src = pkgs.fetchurl {
    url = "https://installer.jdownloader.org/JDownloader.jar";
    sha256 = "sha256-OIodAo5ly8Y5M6d43bySZ8FOfnhYOJzjGhC+cwit60A=";
  };

  wrapper = pkgs.writeScript "jdownloader" ''
    #! ${stdenvNoCC.shell}
    PATH=${
      lib.makeBinPath [
        pkgs.jre
        pkgs.coreutils
      ]
    }
    JDJAR=''${XDG_DATA_HOME:-$HOME/.local/share}/jdownloader/JDownloader.jar
    if [ ! -f ''${JDJAR} ]; then
        install -Dm755 ${src} ''${JDJAR}
    fi
    ${pkgs.jre}/bin/java -jar ''${JDJAR} "''${@}"
  '';
in
stdenvNoCC.mkDerivation rec {
  pname = "jdownloader2";
  version = "2.0";

  inherit src;

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [
    jre
    graphicsmagick
    copyDesktopItems
  ];

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "JDownloader 2";
      exec = wrapper;
      icon = "jdownloader";
      comment = "Free, open-source download management tool.";
      desktopName = "JDownloader 2";
      genericName = "JDownloader 2";
      categories = [ "Network" ];
    })
  ];

  installPhase = ''
    mkdir -pv $out/bin $out/share/applications
    cp ${src} $out/bin/JDownloader.jar

    for size in 16 24 32 48 64 128 256 512; do
      mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
      gm convert -resize "$size"x"$size" ${icon} $out/share/icons/hicolor/"$size"x"$size"/apps/jdownloader.png
    done

    copyDesktopItems
  '';

}

{ inputs, ... }:
{
  flake-file.inputs.kwin-effects-better-blur-dx = {
    url = "github:xarblu/kwin-effects-better-blur-dx";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.plasma.default-packages = {
    nixos =
      {
        isHandheld,
        isPhone,
        lib,
        pkgs,
        ...
      }:
      {
        environment = {
          plasma6.excludePackages = with pkgs.kdePackages; [
            elisa
            khelpcenter
            ktexteditor
            kate
          ];
          systemPackages =
            with pkgs.kdePackages;
            [
              filelight
              kcharselect
              kdegraphics-thumbnailers
              kdenetwork-filesharing
              kdf
              kfind
              kget
              kjournald
              krdc
              ksystemlog
              ktorrent
              partitionmanager
              pkgs.ffmpegthumbnailer
              pkgs.pinentry-qt
              pkgs.qt5.qtgraphicaleffects
              pkgs.qt5.qtquickcontrols2
              pkgs.systemdgenie
              polkit-qt-1
              qtmultimedia
              qtquick3d
              qtstyleplugin-kvantum
              sweeper
            ]
            ++ (lib.optionals (!isPhone) [
            	kamoso
            	kbackup
             	kompare
              inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
              kcalc
              kmix
              pkgs.application-title-bar
              pkgs.heaptrack
              pkgs.icoextract
              pkgs.icoutils
              pkgs.kdePackages.isoimagewriter
              pkgs.kdiff3
              pkgs.kdiskmark
              pkgs.krename
              pkgs.krita
              pkgs.krusader
              pkgs.okteta
              pkgs.onboard
              pkgs.ulauncher
              sddm-kcm
            ])
            ++ (lib.optionals (!isHandheld && !isPhone) [
            	kontrast
            	pkgs.qpwgraph
             	kcolorchooser
              pkgs.graphviz
              pkgs.kdePackages.isoimagewriter
              pkgs.krename
              pkgs.kurve
              pkgs.ulauncher
            ]);
        };
      };

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
          with self'.packages;
          [
            appimage-thumbnailer
            ffmpeg-audio-thumbnailer
            jar-thumbnailer
            kde-thumbnailer-apk
            kzones
            layan
          ]
          ++ (lib.optionals (!isPhone) [
            kf6-servicemenus-rootactions
            kmenu
            kde-control-station
            maxwell
            panel-spacer-extended
            plasma-drawer
            sticky-window-snapping
            virtual-desktops-only-on-primary
            wallpaper-effects
          ]);
      };
  };
}

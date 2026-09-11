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

              kbackup
              kcharselect
              kcolorchooser
              kdegraphics-thumbnailers
              kdenetwork-filesharing
              kdf
              kfind
              kget
              kjournald
              kmix
              kompare
              kontrast
              krdc
              ksystemlog
              ktorrent
              partitionmanager
              pkgs.ffmpegthumbnailer
              pkgs.graphviz
              pkgs.heaptrack
              pkgs.icoextract
              pkgs.icoutils
              pkgs.kdiskmark
              pkgs.krusader
              pkgs.kurve
              pkgs.pinentry-qt
              pkgs.qpwgraph
              pkgs.qt5.qtgraphicaleffects
              pkgs.qt5.qtquickcontrols2
              pkgs.systemdgenie
              polkit-qt-1
              qtmultimedia
              qtquick3d
              qtstyleplugin-kvantum
              sddm-kcm
              sweeper
            ]
            ++ (lib.optionals (!isPhone) [
            	kamoso
              inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
              kcalc
              pkgs.application-title-bar
              pkgs.kdePackages.isoimagewriter
              pkgs.kdiff3
              pkgs.krename
              pkgs.krita
              pkgs.okteta
              pkgs.onboard
              pkgs.ulauncher
            ])
            ++ (lib.optionals (!isHandheld && !isPhone) [
              pkgs.krename
              pkgs.kdePackages.isoimagewriter
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

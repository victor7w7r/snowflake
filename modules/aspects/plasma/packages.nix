{
  inputs,
  lib,
  hosts-attrs,
  ...
}:
{
  den.aspects.plasma.provides =
    lib.genAttrs hosts-attrs.softwaregui (_: {
      nixos =
        { pkgs, ... }:
        {

          flake-file.inputs.kwin-effects-better-blur-dx = {
            url = "github:xarblu/kwin-effects-better-blur-dx";
            inputs.nixpkgs.follows = "nixpkgs";
          };

          environment = {
            plasma6.excludePackages = with pkgs.kdePackages; [
              elisa
              khelpcenter
              kate
            ];
            systemPackages = with pkgs.kdePackages; [
              ark
              baloo-widgets
              dolphin
              dolphin-plugins
              ffmpegthumbs
              filelight
              gwenview
              kamoso
              kbackup
              kcalc
              kcachegrind
              kcharselect
              kcmutils
              kcolorchooser
              kcron
              kdegraphics-thumbnailers
              kdenetwork-filesharing
              kdf
              kfind
              kget
              kgpg
              kjournald
              kmix
              koko
              kompare
              konsole
              kontrast
              krdc
              krdp
              ktorrent
              ksystemlog
              kwallet
              kwallet-pam
              okular
              plasma-workspace
              plasma-desktop
              plasma-integration
              partitionmanager
              polkit-qt-1
              polkit-kde-agent-1
              qtmultimedia
              qtstyleplugin-kvantum
              sddm-kcm
              sweeper
              yakuake
              inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default
              libsForQt5.qt5.qtquickcontrols2
              libsForQt5.qt5.qtgraphicaleffects
              qtquick3d
              qtvirtualkeyboard
              #heaptrack
              ffmpegthumbnailer
              graphviz
              icoextract
              icoutils
              kdiff3
              kdiskmark
              #krita
              krusader
              maliit-keyboard
              onboard
              qpwgraph
              #okteta
              pinentry-qt
              systemdgenie
            ];
          };
        };
    })
    // lib.genAttrs hosts-attrs.peripheralgui (_: {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs.kdePackages; [
            krename
            isoimagewriter
            ulauncher
          ];
        };
    });
}

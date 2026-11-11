{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation {
  pname = "xfce4-diskperf-plugin";
  version = "2.8.0-r124-g6d2e0ee";

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.xfce.org";
    owner = "panel-plugins";
    repo = "xfce4-diskperf-plugin";
    rev = "master";
    sha256 = "sha256-cgUw1GDboadL8GXDmbtwn50xqg0dyisPGGrsG0qolV0=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    intltool
    wrapGAppsHook3
  ];
  buildInputs = with pkgs; [
    xfce4-panel
    libxfce4ui
    libxfce4util
    glib
  ];
}

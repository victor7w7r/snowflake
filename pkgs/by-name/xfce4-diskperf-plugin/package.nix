{ pkgs, stdenv }:

stdenv.mkDerivation {
  pname = "xfce4-diskperf-plugin";
  version = "2.8.0-r124-g6d2e0ee";

  src = pkgs.fetchFromGitLab {
    domain = "gitlab.xfce.org";
    owner = "panel-plugins";
    repo = "xfce4-diskperf-plugin";
    rev = "6d2e0ee87425110ebf6d9e03fa374826f047ff3a";
    sha256 = "sha256-R7vV+HwQOnXN9VnZgTId7Ias9U3GzYp8X0uQ9hM4wD4=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    intltool
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [
    xfce.xfce4-panel
    xfce.libxfce4ui
    xfce.libxfce4util
    glib
  ];
}

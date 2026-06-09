{
  cmake,
  fetchgit,
  glib,
  meson,
  ninja,
  pipewire,
  pkg-config,
  stdenv,
  systemd,
}:
stdenv.mkDerivation {
  pname = "uresourced";
  version = "0.5.4-907d9198";
  src = fetchgit {
    url = "https://gitlab.freedesktop.org/benzea/uresourced.git";
    rev = "907d91989f50842caaf9d681e82a9d6791701927";
    sha256 = "sha256-WTTQYk8tADY9BIfeQ5kFuBbODbRWW8/YCw3vp6O032o=";
  };

  nativeBuildInputs = [
    meson
    pkg-config
    cmake
    ninja
  ];

  buildInputs = [
    glib
    systemd
    pipewire
  ];

  mesonFlags = [
    "-Dsystemdsystemunitdir=${placeholder "out"}/lib/systemd/system"
    "-Dappmanagement=true"
  ];
}

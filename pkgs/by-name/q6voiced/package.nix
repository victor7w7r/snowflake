{
  cache-stdenv,
  inputs,
  pkgs,
}:
cache-stdenv.mkDerivation {
	pname = "q6voiced";
  version = "0.2.1";

  src = inputs.q6voiced;

  buildInputs = with pkgs; [
    alsa-lib
    dbus
    glib
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    meson
    ninja
  ];

  configurePhase = ''
    meson setup build . --prefix=$out
    cd build
  '';
}

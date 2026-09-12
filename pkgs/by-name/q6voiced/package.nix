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
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];
}

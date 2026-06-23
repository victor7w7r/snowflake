{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "gtkhash-thunar";
  version = "1.5";

  src = pkgs.fetchurl {
    url = "https://github.com/tristanheaven/gtkhash/releases/download/v${attrs.version}/gtkhash-${attrs.version}.tar.xz";
    sha256 = "7102a192eca3e82ed67a8252a6850440e50c1dbea7c6364bda154ec80f8ff005";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    intltool
    appstream-glib

    desktop-file-utils
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [
    gtk3
    dconf
    libb2
    libgcrypt
    nettle
    librsvg
    xfce.thunar
  ];

  mesonFlags = [
    "-Dglib-checksums=true"
    "-Dlinux-crypto=true"
    "-Dnettle=true"
    "-Dbuild-caja=false"
    "-Dbuild-nautilus=false"
    "-Dbuild-nemo=false"
    "-Dbuild-thunar=true"
  ];

  doCheck = true;
})

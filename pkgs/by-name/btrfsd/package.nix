{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "btrfsd";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "ximion";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-EgNC8hwZxf5e2MTNP1ysT9++OsJ5aUO/U820j92DOs8=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    libxslt
    docbook_xsl
  ];

  buildInputs = with pkgs; [
    util-linux
    json-glib
    glib
    systemd
  ];

  preConfigure = ''
    if [ -f data/meson.build ]; then
      sed -i "s|systemd_unit_dir = .*|systemd_unit_dir = '$out/lib/systemd/system'|g" data/meson.build
    fi
  '';

  pkgconfigSystemdSystemUnitDir = "${placeholder "out"}/lib/systemd/system";
  mesonBuildType = "debugoptimized";
})

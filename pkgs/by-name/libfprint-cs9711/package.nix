{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "libfprint-cs9711";
  version = "1.94.10-cs9711";

  src = pkgs.fetchFromGitHub {
    owner = "archeYR";
    repo = "libfprint-CS9711";
    rev = "02b285c9703c38d308fbe47a3c566ef1e7f883ca";
    hash = "sha256-QGrBNqbRNqLZIURI66xkenlQamNW+DQU4WS+CLN4zM8=";
  };

  postPatch = ''
    patchShebangs \
      tests/unittest_inspector.py \
      tests/virtual-image.py \
      tests/umockdev-test.py \
      tests/test-generated-hwdb.sh
  '';

  nativeBuildInputs = with pkgs; [
    pkg-config
    meson
    ninja
    python3
    gobject-introspection
    udevCheckHook
  ];

  buildInputs = with pkgs; [
    glib
    gusb
    pixman
    cairo
    libgudev
    openssl
    opencv4
    doctest
  ];

  mesonFlags = [
    "-Ddrivers=all"
    "-Ddoc=false"
    "-Dgtk-examples=false"
    "-Dinstalled-tests=false"
    "-Dudev_rules=enabled"
    "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
    "-Dudev_hwdb=enabled"
    "-Dudev_hwdb_dir=${placeholder "out"}/lib/udev/hwdb.d"
  ];

  doCheck = false;
  doInstallCheck = true;
  nativeInstallCheckInputs = [ (pkgs.python3.withPackages (p: with p; [ pygobject3 ])) ];
  installCheckPhase = "ninjaCheckPhase";
}

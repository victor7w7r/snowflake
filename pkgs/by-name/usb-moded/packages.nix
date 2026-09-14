{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation (attrs: {
  pname = "usb-moded";
  version = "0.86.0+mer69";

  src = pkgs.fetchFromGitHub {
    owner = "sailfishos";
    repo = "usb-moded";
    tag = "mer/${attrs.version}";
    fetchSubmodules = true;
    hash = "sha256-4ocRvcy2Q+jxZesO0G8i5/PUDnT2ZoOYMQk0yBzWuP0=";
  };

  patches = map (patch: "${attrs.passthru.patches}/${patch}") [
    "basename.patch"
    "0001-dyn-config-Add-option-for-running-a-command-on-mode-.patch"
    "0002-worker-generalize-MTP-daemon-to-FunctionFS-daemon.patch"
    "0003-worker-only-check-daemon-running-in-FunctionFS-mode.patch"
    "0004-configfs-Register-NCM-gadget-for-USB-networking.patch"
  ];

  nativeBuildInputs = with pkgs; [
    autoreconfHook
    pkg-config
  ];

  buildInputs = with pkgs; [
    dbus
    eudev
    glib
    gobject-introspection
    kmod
    systemd
    ssu-sysinfo
  ];

  configureFlags = [
    "--enable-connman"
    "--enable-ofono"
    "--enable-app-sync"
    "--enable-systemd"
  ];

  postInstall = ''
    install -Dm644 usb_moded.pc -t $out/lib/pkgconfig/

    install -Dm644 systemd/usb-moded.service -t $out/lib/systemd/system/
    substituteInPlace $out/lib/systemd/system/usb-moded.service \
      --replace-fail "/usr/sbin/usb_moded" "$out/bin/usb_moded"

    install -Dm644 debian/usb_moded.conf -t $out/share/dbus-1/system.d/
  '';

  passthru.patches =
    pkgs.runCommand "usb-moded-patches"
      {
        version = "0-unstable-2025-04-14";

        src = pkgs.fetchFromGitLab {
          domain = "gitlab.postmarketos.org";
          owner = "postmarketOS";
          repo = "pmaports";
          rev = "97d87482ba52b87c2f01827cd64731996d7ffbac";
          sparseCheckout = [ "temp/usb-moded" ];
          hash = "sha256-PhPpIzOPG2Puk2WP7aI6t8FX1ivXiAt+pRl70/UrGQg=";
        };
      }
      '' install -D $src/temp/usb-moded/*.patch -t $out'';
})

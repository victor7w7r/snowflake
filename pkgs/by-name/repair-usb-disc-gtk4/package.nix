{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "repair-usb-disc-gtk4";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/linux-stuffs/linux-goodies/-/raw/master/repair-usb-disc-gtk4/distrib/repair-usb-disc-gtk4-0.1-0.tar.gz";
    sha256 = "sha256-hSEmrF2iSCW4whZIXSmk0AAAG8S/j4MhTm7K2eeu+UU=";
  };

  nativeBuildInputs = with pkgs; [
    gobject-introspection
    wrapGAppsHook4
    python3.pkgs.wrapPythonPrograms
  ];

  buildInputs = with pkgs; [
    python3
    python3.pkgs.pygobject3
    gtk4
    util-linux
    ntfs3g
    exfatprogs
    dosfstools
    repair-usb-disc
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  makeWrapperArgs = with pkgs; [
    "--prefix"
    "PATH"
    ":"
    "${stdenv.lib.makeBinPath [
      util-linux
      ntfs3g
      exfatprogs
      dosfstools
    ]}"
  ];

  postFixup = "wrapPythonPrograms";
})

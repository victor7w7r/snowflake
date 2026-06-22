{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "repair-usb-disc";
  version = "master";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/linux-stuffs/linux-goodies/-/raw/master/repair-usb-disc-gtk4/distrib/repair-usb-disc-gtk4-0.1-0.tar.gz";
    sha256 = "sha256-47DEQpj8HBSa+/TImW+5AAAAQeRkm5NMpJWZG3hSuFU=";
  };

  buildInputs = with pkgs; [
    python3
  ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
    pkg-config
  ];

  makeFlags = [ "PREFIX=$(out)" ];
})

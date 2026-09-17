{ pkgs, stdenvNoCC }:

stdenvNoCC.mkDerivation (attrs: {
  pname = "sunnify";
  version = "2.4.2";

  src = pkgs.fetchurl {
    url = "https://github.com/sunnypatell/sunnify-spotify-downloader/releases/download/v2.4.2/Sunnify-Linux";
    sha256 = "sha256-Mccde2hAASmrS7vKk29wDUwkWr/fVzvAFm5g31yYQ1A=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    libGL
    glib
    zlib
    fontconfig
    freetype
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libXfixes
    xorg.libxcb
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/sunnify
    chmod +x $out/bin/sunnify

    wrapProgram $out/bin/sunnify \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath attrs.buildInputs}"
  '';
})

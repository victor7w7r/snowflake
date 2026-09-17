{ pkgs, stdenvNoCC }:

stdenvNoCC.mkDerivation (attrs: {
  pname = "sunnify";
  version = "2.4.2";

  src = pkgs.fetchurl {
    url = "https://github.com/sunnypatell/sunnify-spotify-downloader/releases/download/v2.4.2/Sunnify-Linux";
    sha256 = "sha256-gMHszaaQhTz4idM0v0WQLU+yI6QR7uJlDc5hfrQ1qzA=";
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
    libX11
    libXext
    libXrender
    libXi
    libXrandr
    libXcursor
    libXdamage
    libXcomposite
    libXfixes
    libxcb
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/sunnify
    chmod +x $out/bin/sunnify

    wrapProgram $out/bin/sunnify \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath attrs.buildInputs}"
  '';
})

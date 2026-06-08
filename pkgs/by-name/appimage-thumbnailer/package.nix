{
  bash,
  imagemagick,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "appimage-thumbnailer";
  version = "main";

  src = fetchFromGitHub {
    owner = "realmazharhussain";
    repo = pname;
    rev = version;
    sha256 = "sha256-Y7s9qdJIJbUqEP0/6qlTPOtE3efRqL1bx66MJIPgRN4=";
  };

  buildInputs = [
    bash
    imagemagick
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/thumbnailers
    mv AppImage-thumbnailer "$out/bin/"
    mv AppImage-thumbnailer.thumbnailer "$out/share/thumbnailers/"
    chmod +x $out/bin/AppImage-thumbnailer
  '';
}

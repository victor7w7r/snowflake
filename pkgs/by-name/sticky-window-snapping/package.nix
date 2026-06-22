{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "sticky-window-snapping";
  version = "master";

  src = fetchFromGitHub {
    owner = "Flupp";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-5xkKNgwzItnpdqk2z/HiCtXNm/ZyjXflSJcT1dAn6nU=";
  };

  installPhase = ''
    mkdir -p $out/share/kwin/scripts/sticky-window-snapping
    cp -r * $out/share/kwin/scripts/sticky-window-snapping/
  '';
})

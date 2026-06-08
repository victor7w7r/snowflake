{
  stdenvNoCC,
  fetchurl,
  unzip,
}:
let
  url = "https://github.com/fathyb/carbonyl/releases/download/v0.0.3";
in
stdenvNoCC.mkDerivation {
  pname = "carbonyl";
  version = "main";

  srcAmd = fetchurl {
    url = "${url}/carbonyl.linux-amd64.zip";
    sha256 = "sha256-RqkC6im7Mvdz+07jQUI3BbkjRagQQiuN+T6upqHsetI=";
  };

  srcArm = fetchurl {
    url = "${url}/carbonyl.linux-arm64.zip";
    sha256 = "sha256-W3XJkTjNq+RUk14sYJlK3OC9RXHxbk7s/fhnxZoRl74=";
  };

  nativeBuildInputs = [ unzip ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    unzip ${if stdenvNoCC.hostPlatform.isAarch64 then "$srcArm" else "$srcAmd"} -d $out/
    mv $out/carbonyl-0.0.3/* $out/bin/ && rm -rf $out/carbonyl-0.0.3
    chmod +x $out/bin/carbonyl
  '';
}

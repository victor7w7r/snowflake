{
  fetchFromGitHub,
  pkg-config,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "ytdl";
  version = "main";

  src = fetchFromGitHub {
    owner = "codewithmoss";
    repo = pname;
    rev = version;
    sha256 = "sha256-CXfULAr3f3SQSwHmaUPnpW/uwBmr6fwXCmDeiL944f8=";
  };

  nativeBuildInputs = [ pkg-config ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/ytdl.sh $out/bin/ytdl
    chmod +x $out/bin/ytdl
  '';
}

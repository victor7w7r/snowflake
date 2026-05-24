{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  pname = "ytdl";
  version = "HEAD";

  src = pkgs.fetchFromGitHub {
    owner = "codewithmoss";
    repo = pname;
    rev = version;
    sha256 = "sha256-CXfULAr3f3SQSwHmaUPnpW/uwBmr6fwXCmDeiL944f8=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/ytdl.sh $out/bin/ytdl
    chmod +x $out/bin/ytdl
  '';
}

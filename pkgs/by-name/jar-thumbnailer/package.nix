{
  fetchFromGitHub,
  stdenvNoCC,
  bash,
  unzip,
  coreutils,
  gnused,
}:
stdenvNoCC.mkDerivation rec {
  pname = "jar-thumbnailer";
  version = "main";

  src = fetchFromGitHub {
    owner = "realmazharhussain";
    repo = pname;
    rev = version;
    sha256 = "sha256-UNPH8cmp3h8xrUxYlMqzsr5vj9wLO8dZe76emtDDWfI=";
  };

  buildInputs = [
    bash
    unzip
    coreutils
    gnused
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/thumbnailers
    mv jar-thumbnailer "$out/bin/"
    mv jar.thumbnailer "$out/share/thumbnailers/"
    chmod +x $out/bin/jar-thumbnailer
  '';
}

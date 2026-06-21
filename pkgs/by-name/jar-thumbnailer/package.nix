{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "jar-thumbnailer";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "realmazharhussain";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-UNPH8cmp3h8xrUxYlMqzsr5vj9wLO8dZe76emtDDWfI=";
  };

  buildInputs = with pkgs; [
    coreutils
    bash
    gnused
    unzip
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/thumbnailers
    mv jar-thumbnailer "$out/bin/"
    mv jar.thumbnailer "$out/share/thumbnailers/"
    chmod +x $out/bin/jar-thumbnailer
  '';
})

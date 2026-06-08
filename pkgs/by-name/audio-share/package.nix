{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "audio-share";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://github.com/mkckr0/audio-share/releases/download/v0.3.4/audio-share-server-cmd-linux.tar.gz";
    sha256 = "sha256-3PJculwZ8L7YwS7Hw3RSHlx9mL5Q0M6YhiUWELtDUk8=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    tar -xvf $src -C $out
    mv $out/audio-share-server-cmd/bin/as-cmd $out/bin/audio-share
    rm -rf $out/audio-share-server-cmd/bin/as-cmd
    chmod +x $out/bin/audio-share
  '';
}

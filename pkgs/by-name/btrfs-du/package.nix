{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "btrfs-du";
  version = "master";

  src = fetchFromGitHub {
    owner = "nachoparker";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-5A/WDZkWs1fmwQilukYDC9Fug1vG+LPUQWe79ZwSW1M=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/btrfs-du $out/bin/btrfs-du
    chmod +x $out/bin/btrfs-du
  '';
})

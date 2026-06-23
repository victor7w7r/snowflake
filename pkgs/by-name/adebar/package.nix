{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "adebar";
  version = "main";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "izzy";
    repo = "Adebar";
    rev = "master";
    hash = "sha256-3sS11Aoal6JNU+uXvAAAALM40dsCqc/vb4o2ZYB2JgQ=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/* $out/bin/
  '';
})

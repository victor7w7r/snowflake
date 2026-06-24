{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "adebar";
  version = "main";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "izzy";
    repo = "Adebar";
    rev = "master";
    hash = "sha256-UTBBiwF3RsgwDz6WIXQ+jWIMvMbeFdU9aOUcj7C8wEY=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
  '';
})

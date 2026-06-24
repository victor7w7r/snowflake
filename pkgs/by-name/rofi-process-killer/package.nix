{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "rofi-process-killer";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "madhur";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-UjLU6s70YmaA6Ztt6d3KkOxVH/kkJfCYaNtRqNy+r4s=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    chmod +x $out/bin/rofi-process-killer.sh
  '';
})

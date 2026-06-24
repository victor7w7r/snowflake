{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "rofi-process-killer";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "madhur";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-2wGjbs8Ppgd3TRaAAut13It+LjtWTwJM8vYlPfI9uMo=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    chmod +x $out/bin/rofi-process-killer.sh
  '';
})

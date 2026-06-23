{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "app-manager";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "ASHWIN990";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-WJ+AEB3F2oC9ayPi1+wPEc9kOBeB8rDgJcDxEcC5Zi0=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/app-manager $out/bin/app-manager
  '';
})

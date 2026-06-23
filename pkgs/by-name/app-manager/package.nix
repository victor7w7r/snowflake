{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "app-manager";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "ASHWIN990";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Y7s9qdJIJbUqEP0/6AAOtE3efRqL1bx66MJIPgRN4=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/app-manager $out/bin/app-manager
  '';
})

{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "frenzch.sh";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "FrenzyExists";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-JNHNqnNqap19LHuRxyekTzXJQPlJclgmQdR/pnjLYdU=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin

    cp $src/frenzch.sh $out/bin/frenzch
    cp $src/info.sh $out/bin/info.sh
    cp $src/bash_jesus.sh $out/bin/bash_jesus.sh

    chmod +x $out/bin/frenzch
    chmod +x $out/bin/info.sh
    chmod +x $out/bin/bash_jesus.sh
  '';

})

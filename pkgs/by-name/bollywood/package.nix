{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "bollywood";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "abloch";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KZlrh+GWknAQ9AAALO8hK+MeUrrT2ode9VO+ZohpOJA=";
  };

  buildInputs = with pkgs; [ zellij ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/config.kdl $out/bin/
    cp $src/layout.kdl $out/bin/
    cp $src/stam.sh $out/bin/
    cp ${pkgs.writeScriptBin "bollywood-invoke" ''
      #!/usr/bin/env bash
      zellij -l layout.kdl --config config.kdl
    ''}/bin/bollywood-invoke $out/bin/bollywood
  '';
})

{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "cliwrap";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "islemci";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-9pb1reyNzxuAnEt8im2dzK1JKCZxiNOR+VioloJLNT0=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/cliwrap $out/bin/cliwrap
    chmod +x $out/bin/cliwrap
  '';
})

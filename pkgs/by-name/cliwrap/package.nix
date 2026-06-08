{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  pname = "cliwrap";
  version = "HEAD";

  src = pkgs.fetchFromGitHub {
    owner = "islemci";
    repo = pname;
    rev = version;
    sha256 = "sha256-9pb1reyNzxuAnEt8im2dzK1JKCZxiNOR+VioloJLNT0=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/cliwrap $out/bin/cliwrap
    chmod +x $out/bin/cliwrap
  '';
}

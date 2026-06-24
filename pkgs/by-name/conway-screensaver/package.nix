{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "conway-screensaver";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "cdkw2";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-YwiMRH7cj6TSxsBu+sRUnHF1sjVTo6vkQOdvZBTqzrM=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    autoconf
    automake
  ];

  buildFlags = [ "all" ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/doc/conway-screensaver
    cp conway-screensaver $out/bin/
    chmod +x $out/bin/conway-screensaver
    cp game_of_life.conf $out/share/doc/conway-screensaver/
  '';

  postPatch = ''
    if [ -f conway-screensaver.c ]; then
      echo "Parcheando rutas dentro del código fuente C..."
      sed -i "s|/usr/share/doc|$out/share/doc|g" conway-screensaver.c
    fi
  '';
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "sandscreen";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "frostyarchtide";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-iEDVharT1C28Wm7JlSqRrISqBNJv7Y2soaaJX1oX+Ro=";
  };

  buildInputs = with pkgs; [ ncurses ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${attrs.pname} $out/bin/ || cp bin/${attrs.pname} $out/bin/ || cp ./* $out/bin/ 2>/dev/null || true
  '';
})

{
  cmake,
  ncurses,
  fetchFromGitHub,
  pkg-config,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "sandscreen";
  version = "master";

  src = fetchFromGitHub {
    owner = "frostyarchtide";
    repo = pname;
    rev = version;
    sha256 = "sha256-iEDVharT1C28Wm7JlSqRrISqBNJv7Y2soaaJX1oX+Ro=";
  };

  buildInputs = [ ncurses ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/ || cp bin/${pname} $out/bin/ || cp ./* $out/bin/ 2>/dev/null || true
  '';
}

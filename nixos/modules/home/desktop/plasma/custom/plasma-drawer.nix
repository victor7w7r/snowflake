{
  stdenv,
  fetchFromGitHub,
  kdePackages,
  libsForQt5,
  zip,
}:
stdenv.mkDerivation {
  pname = "plasma-drawer";
  version = "unstable-dev-2025-02-23";

  src = fetchFromGitHub {
    owner = "p-connor";
    repo = "plasma-drawer";
    rev = "a1eec560875e9715ea3cf6e861b7a052abfd70f2";
    sha256 = "sha256-1RShJo74wS2Y98RyAlTozR0mcrF+3oKJ9yv7L/u1Uzo=";
  };

  postPatch = ''
    substituteInPlace Makefile \
      --replace-fail 'kpackagetool6 -t Plasma/Applet' 'kpackagetool6'

    substituteInPlace Makefile \
      --replace-fail 'desktoptojson' '${kdePackages.kcoreaddons}/bin/desktoptojson' \
      --replace-fail 'kpackagetool6' 'kpackagetool6 --packageroot $(out)/share/plasma/plasmoids'
  '';

  nativeBuildInputs = [
    kdePackages.kpackage
    kdePackages.kconfig
    zip
  ];
  dontWrapQtApps = true;
}

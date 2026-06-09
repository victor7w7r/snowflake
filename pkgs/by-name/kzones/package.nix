{
  fetchFromGitHub,
  stdenvNoCC,
  kdePackages,
  zip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "kzones";
  version = "main";

  src = fetchFromGitHub {
    owner = "gerritdevriese";
    repo = pname;
    rev = version;
    hash = "sha256-xqTQiL+7T6p+Y86eC5InAk6waYoM82iFoLflkN6/dG8=";
  };

  nativeBuildInputs = [
    kdePackages.kpackage
    zip
  ];

  buildInputs = [ kdePackages.kwin ];
  dontWrapQtApps = true;
  buildFlags = [ "build" ];

  installPhase = ''
    kpackagetool6 --type=KWin/Script --install=kzones.kwinscript --packageroot=$out/share/kwin/scripts
  '';
}

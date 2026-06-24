{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "kzones";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "gerritdevriese";
    repo = attrs.pname;
    rev = attrs.version;
    hash = "sha256-xqTQiL+7T6p+Y86eC5InAk6waYoM82iFoLflkN6/dG8=";
  };

  nativeBuildInputs = with pkgs; [
    kdePackages.kpackage
    zip
  ];

  buildInputs = with pkgs; [ kdePackages.kwin ];
  dontWrapQtApps = true;
  buildFlags = [ "build" ];

  installPhase = ''
    kpackagetool6 --type=KWin/Script --install=kzones.kwinscript --packageroot=$out/share/kwin/scripts
  '';
})

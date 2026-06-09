{
  fetchFromGitHub,
  stdenv,
  nix-update-script,
  cava,
  qt6,
  python3,
}:
stdenv.mkDerivation rec {
  pname = "kurve";
  version = "2.0.0";
  dontWrapQtApps = true;

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "kurve";
    tag = "v${version}";
    hash = "sha256-qw/6V3TWGZFL8dgyDUxzBr4U6/jaX9uwpyg3Bd3pKdg=";
  };

  installPhase =
    let
      pythonEnv = python3.withPackages (ps: [ ps.websockets ]);
    in
    ''
      runHook preInstall
      substituteInPlace package/contents/ui/components/ProcessMonitorFallback.qml --replace-fail "import QtWebSockets" "import \"file:${qt6.qtwebsockets}/lib/qt-6/qml/QtWebSockets\""
      substituteInPlace package/contents/ui/Cava.qml --replace-fail "cava -p" "${cava}/bin/cava -p"
      substituteInPlace package/contents/ui/FullRepresentation.qml --replace-fail "cava -v" "${cava}/bin/cava -v"
      substituteInPlace package/contents/ui/tools/commandMonitor --replace-fail "#!/usr/bin/env python3" "#!${pythonEnv}/bin/python3"
      mkdir -p $out/share/plasma/plasmoids/luisbocanegra.audio.visualizer
      cp -r package/* $out/share/plasma/plasmoids/luisbocanegra.audio.visualizer
      runHook postInstall
    '';

  passthru.updateScript = nix-update-script { };
}

{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "kde-wallpaper-effects-widget";
  version = "2.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-wallpaper-effects";
    rev = "refs/tags/v${attrs.version}";
    hash = "sha256-fhVxhJESbCkm0WItBCEN83RvSwzjYGgCVyX/3j51uhA=";
  };

  dontBuild = true;
  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/luisbocanegra.desktop.wallpaper.effects
    cp -r $src/package/* $out/share/plasma/plasmoids/luisbocanegra.desktop.wallpaper.effects
  '';

  passthru.updateScript = pkgs.nix-update-script { };
})

{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "kde-panel-spacer-extended-widget";
  version = "1.12.0";

  src = pkgs.fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-panel-spacer-extended";
    rev = "refs/tags/v${attrs.version}";
    hash = "sha256-Rr80bI+9xnrlj8JNTL+vGqOw9/98R0ub0pQfHQmEWNM=";
  };

  propagatedUserEnvPkgs = with pkgs; [ glib ];

  dontBuild = true;
  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/luisbocanegra.panelspacer.extended
    cp -r $src/package/* $out/share/plasma/plasmoids/luisbocanegra.panelspacer.extended
  '';

  passthru.updateScript = pkgs.nix-update-script { };
})

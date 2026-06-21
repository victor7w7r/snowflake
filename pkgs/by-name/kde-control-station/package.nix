{
  fetchFromGitHub,
  kdePackages,
  stdenvNoCC,
  nix-update-script,
}:
stdenvNoCC.mkDerivation(attrs: {
  pname = "kde-control-station";
  version = "plasma6";

  src = fetchFromGitHub {
    owner = "EliverLarASpname";
    rev = attrs.version;
    sha256 = "sha256-Hjjz3RefycImPgAuTUchr8Jikh4HlLf+fOPuh0aMP2M=";
  };

  propagatedUserEnvPkgs = with kdePackages; [
    kdeconnect-kde
    kdeplasma-addons
    plasma-nm
    plasma-pa
    powerdevil
  ];

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/KdeControlStation
    cp -r package/* $out/share/plasma/plasmoids/KdeControlStation

  passthru.updateScript = nix-update-script { };
}

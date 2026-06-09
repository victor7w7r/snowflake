{
  fetchFromGitHub,
  kdePackages,
  stdenvNoCC,
  nix-update-script,
}:
stdenvNoCC.mkDerivation rec {
  pname = "kde-control-station";
  version = "plasma6";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = pname;
    rev = version;
    sha256 = "sha256-Hjjz3RefycImPgAuTUchr8Jikh4HlLf+fOPuh0aMP2M=";
  };

  propagatedUserEnvPkgs = with kdePackages; [
    plasma-nm
    kdeplasma-addons
    plasma-pa
    powerdevil
    kdeconnect-kde
  ];

  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/KdeControlStation
    cp -r package/* $out/share/plasma/plasmoids/KdeControlStation
  '';

  passthru.updateScript = nix-update-script { };
}

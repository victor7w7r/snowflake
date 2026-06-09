{ fetchFromGitHub, stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  pname = "kMenu";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "51n7";
    repo = pname;
    rev = version;
    sha256 = "sha256-Ium+RmV8zieSqHFZul4MdRZFKPUKmJVCoo2OoLCrwzk=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids
    mv package $out/share/plasma/plasmoids/org.51n7.kMenu
  '';
}

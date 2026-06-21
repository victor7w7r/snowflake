{
  meson,
  ninja,
  pkg-config,
  fetchFromGitHub,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "btrfsd";
  version = "master";

  src = fetchFromGitHub {
    owner = "ximion";
    repo = "btrfsd";
    rev = version;
    sha256 = "sha256-S/0sc4Thj1gZAAAxl9bcY+VKcYGhEDi3HzPsBdhKatU=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  mesonBuildType = "debugoptimized";
}

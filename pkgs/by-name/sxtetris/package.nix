{
  alsa-lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "sxtetris";
  version = "main";

  src = fetchFromGitHub {
    owner = "shixinhuang99";
    repo = pname;
    rev = version;
    sha256 = "sha256-xLbC2o0wz9zBZwCuZVmztOlk+gfs+XReN5NeveHgi+4=";
  };
  cargoHash = "sha256-Ntx1xWDP3U0A+0N5t92d7H+y6HiA32D54K1wbJucyoc=";

  buildInputs = [ alsa-lib ];
  nativeBuildInputs = [ pkg-config ];
}

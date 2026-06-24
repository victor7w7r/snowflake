{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "sxtetris";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "shixinhuang99";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-xLbC2o0wz9zBZwCuZVmztOlk+gfs+XReN5NeveHgi+4=";
  };
  cargoHash = "sha256-Ntx1xWDP3U0A+0N5t92d7H+y6HiA32D54K1wbJucyoc=";

  buildInputs = with pkgs; [ alsa-lib ];
  nativeBuildInputs = with pkgs; [ pkg-config ];
})

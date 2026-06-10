{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "diskonaut";
  version = "0.11.0";

  src = pkgs.fetchFromGitHub {
    owner = "imsnif";
    repo = pname;
    rev = version;
    sha256 = "sha256-pLQosVnAQZ82OUcR/wD8QnYs9JVJZ+HrB0NNkcdTq94=";
  };

  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = with pkgs; [
    pkg-config
    sccache
  ];

  RUSTC_WRAPPER = "sccache";
  SCCACHE_DIR = "/nix/var/cache/sccache";
}

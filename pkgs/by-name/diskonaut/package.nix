{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "diskonaut";
  version = "0.11.0";

  src = pkgs.fetchFromGitHub {
    owner = "imsnif";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-pLQosVnAQZ82OUcR/wD8QnYs9JVJZ+HrB0NNkcdTq94=";
  };

  doCheck = false;
  cargoLock.lockFile = "${attrs.src}/Cargo.lock";

  #  RUSTC_WRAPPER = "sccache";
  # SCCACHE_DIR = "/nix/var/cache/sccache";
})

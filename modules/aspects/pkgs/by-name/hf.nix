{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "hf";
  version = "0.5.1";

  src = pkgs.fetchFromGitHub {
    owner = "sorairolake";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-NFBFZ4o5HG5iVFgkH2XOq7pc03vRXbScU2NFQwz3oiA=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    sccache
  ];

  RUSTC_WRAPPER = "sccache";
  SCCACHE_DIR = "/nix/var/cache/sccache";
  cargoLock.lockFile = "${src}/Cargo.lock";
}

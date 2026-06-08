{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "loop";
  version = "HEAD";

  src = pkgs.fetchFromGitHub {
    owner = "Miserlou";
    repo = pname;
    rev = version;
    sha256 = "sha256-0nUZP7PRhsw+BOnDF3E7Mb8qngUVHjFdh8PFgJbDFy0=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    sccache
  ];

  cargoHash = "sha256-ZKr99Lr+EOSXBpHL4hCwG+5xavJWI3ah/illd15i7g0=";
  RUSTC_WRAPPER = "sccache";
  SCCACHE_DIR = "/nix/var/cache/sccache";
}

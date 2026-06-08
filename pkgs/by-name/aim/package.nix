{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  perl,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "aim";
  version = "main";

  src = fetchFromGitHub {
    owner = "mihaigalos";
    repo = pname;
    rev = version;
    sha256 = "sha256-p1mjAFKAzvdgQ1Ov8drxHNkYpPg9umf77QTaicCS6oA=";
  };

  cargoHash = "sha256-MPZWb+O1SY/fqTRZZyM9n4ScnzLr0XFAU8a0plSO830=";

  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    perl
  ];

  buildInputs = lib.singleton openssl;

  #RUSTC_WRAPPER = "sccache";
  #SCCACHE_DIR = "/nix/var/cache/sccache";
}

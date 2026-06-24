{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "aim";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "mihaigalos";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-p1mjAFKAzvdgQ1Ov8drxHNkYpPg9umf77QTaicCS6oA=";
  };

  cargoHash = "sha256-MPZWb+O1SY/fqTRZZyM9n4ScnzLr0XFAU8a0plSO830=";
  doCheck = false;

  nativeBuildInputs = with pkgs; [ perl ];
  buildInputs = with pkgs; [ openssl ];

  #RUSTC_WRAPPER = "sccache";
  #SCCACHE_DIR = "/nix/var/cache/sccache";
})

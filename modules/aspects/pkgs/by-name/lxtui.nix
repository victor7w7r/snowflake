{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "lxtui";
  version = "0.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "FoleyBridge-Solutions";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArO3Z5kIAEoLoPkToHoRtM=";
  };

  buildInputs = [ pkgs.openssl ];
  nativeBuildInputs = [ pkgs.pkg-config ];

  cargoHash = "sha256-Rs9NQRlDv0Vt4NQGYs0jvFnlnlJ+wvgwBA4n1ZZ++io=";
}

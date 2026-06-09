{
  fetchFromGitHub,
  openssl,
  pkg-config,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "lxtui";
  version = "main";

  src = fetchFromGitHub {
    owner = "FoleyBridge-Solutions";
    repo = pname;
    rev = "main";
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArO3Z5kIAEoLoPkToHoRtM=";
  };

  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  cargoHash = "sha256-Rs9NQRlDv0Vt4NQGYs0jvFnlnlJ+wvgwBA4n1ZZ++io=";
}

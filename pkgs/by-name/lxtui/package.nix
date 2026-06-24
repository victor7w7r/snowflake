{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "lxtui";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "FoleyBridge-Solutions";
    repo = attrs.pname;
    rev = "main";
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArO3Z5kIAEoLoPkToHoRtM=";
  };

  buildInputs = with pkgs; [ openssl ];
  nativeBuildInputs = with pkgs; [ pkg-config ];

  cargoHash = "sha256-Rs9NQRlDv0Vt4NQGYs0jvFnlnlJ+wvgwBA4n1ZZ++io=";
})

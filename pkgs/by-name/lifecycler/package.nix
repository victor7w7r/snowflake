{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "lifecycler";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "cxreiff";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArO3AAAAAEoLoPkToHoRtM=";
  };

  #buildInputs = with pkgs; [ openssl ];
  #nativeBuildInputs = with pkgs; [ pkg-config ];

  cargoHash = "sha256-Rs9NQRlDv0Vt4NQGYs0AAAnlnlJ+wvgwBA4n1ZZ++io=";
})

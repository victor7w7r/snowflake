{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "rbonsai";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "roberte777";
    repo = attrs.pname;
    rev = "main";
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArOAAAkIAEoLoPkToHoRtM=";
  };

  #buildInputs = with pkgs; [ openssl ];
  #nativeBuildInputs = with pkgs; [ pkg-config ];

  cargoHash = "sha256-Rs9NQRlDv0Vt4NQGYs0jvFnlnlJ+wvAABA4n1ZZ++io=";
})

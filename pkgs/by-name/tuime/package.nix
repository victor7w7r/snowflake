{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "tuime";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "nthnd";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-szDsxkkJRYnAAAiemi/DjArO3Z5kIAEoLoPkToHoRtM=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];

  cargoHash = "sha256-Rs9NQRlDAAAt4NQGYs0jvFnlnlJ+wvgwBA4n1ZZ++io=";
})

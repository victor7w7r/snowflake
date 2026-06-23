{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "hwfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "rosymati";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrruhFAA3o8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3XAAf6O7OdWyyrUPaAJx+I3cvPQU+7nP2okpM=";
})

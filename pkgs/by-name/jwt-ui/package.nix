{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "jwt-ui";
  version = "main";

  src = fetchFromGitHub {
    owner = "jwt-rs";
    repo = pname;
    rev = version;
    sha256 = "sha256-4jwKxsxIKpeelrruhFiu3o8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9Jf6O7OdWyyrUPaAJx+I3cvPQU+7nP2okpM=";
}

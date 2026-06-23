{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "zilch";
  version = "master";

  src = fetchFromGitHub {
    owner = "lavafroth";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrruAAiu3o8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9Jf6OAAdWyyrUPaAJx+I3cvPQU+7nP2okpM=";
})

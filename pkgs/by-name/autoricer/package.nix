{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "autoricer";
  version = "main";

  src = fetchFromGitHub {
    owner = "3rfaan";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrruhFiu3o8AAxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9JfAAAOdWyyrUPaAJx+I3cvPQU+7nP2okpM=";
})

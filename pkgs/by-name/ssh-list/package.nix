{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "ssh-list";
  version = "main";

  src = fetchFromGitHub {
    owner = "akinoiro";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrruhFiAAA8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9Jf6O7OdWyyrUPAAJx+I3cvPQU+7nP2okpM=";
})

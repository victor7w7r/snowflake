{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "mfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "xdearboy";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrAAhFiu3o8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9Jf6O7OdWyyrUPaAJx+IAAvPQU+7nP2okpM=";
})

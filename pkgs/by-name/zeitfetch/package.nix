{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "zeitfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "nidnogg";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-fmA6FPHYfSFvKCv+HjGISV8w/vVI8yCl4ZfwCUI3RS4=";
  };

  cargoHash = "sha256-GM3hY3KY/G1B/ashmjusbnT1tqcP6CdyHyGnaXTskcw=";
})

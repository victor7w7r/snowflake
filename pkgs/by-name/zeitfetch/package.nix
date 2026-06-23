{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "zeitfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "rosymati";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-NilZXb4NL1dz8ParAAAoFUNPleBmylHl54PbzSwjd5E=";
  };

  cargoHash = "sha256-v2IbR1caH+7/XeBmvvWQAA7gV8YZMmGvA5RNoz+kXrI=";
})

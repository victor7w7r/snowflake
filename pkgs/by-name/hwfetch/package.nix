{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "hwfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "rosymati";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-NilZXb4NL1dz8ParRXHoFUNPleBmylHl54PbzSwjd5E=";
  };

  cargoHash = "sha256-v2IbR1caH+7/XeBmvvWQz47gV8YZMmGvA5RNoz+kXrI=";
})

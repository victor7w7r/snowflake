{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "linuxthemestore";
  version = "main";

  src = fetchFromGitHub {
    owner = "debasish-patra-1987";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-4jwKxsxIKpeelrAAAFiu3o8QVxMp+CTNuSXK7XBiXFU=";
  };

  cargoHash = "sha256-ywqXUp3X9Jf6O7OdWyyrUPAAAx+I3cvPQU+7nP2okpM=";
})

{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "cargofetch";
  version = "HEAD";

  src = fetchFromGitHub {
    owner = "arjav0703";
    repo = pname;
    rev = version;
    sha256 = "sha256-zAnQWRqt3qVZx+uKlCteKan9p2NqNvDYgv5dFr5/30g=";
  };

  cargoHash = "sha256-y+QcZHQf1tOq72MFJhLRf0ft5EyZZ+OXcG4g1TFkWfE=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = lib.singleton openssl;
}

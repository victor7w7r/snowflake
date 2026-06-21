{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "cargofetch";
  version = "HEAD";

  src = pkgs.fetchFromGitHub {
    owner = "arjav0703";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-zAnQWRqt3qVZx+uKlCteKan9p2NqNvDYgv5dFr5/30g=";
  };

  cargoHash = "sha256-y+QcZHQf1tOq72MFJhLRf0ft5EyZZ+OXcG4g1TFkWfE=";

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ openssl ];
})

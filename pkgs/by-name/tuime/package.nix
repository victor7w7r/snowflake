{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "tuime";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "nthnd";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-nQwKrQXm+NAdanr3fLIfAuJJuQMh5niaelv1rzvApQo=";
  };

  cargoHash = "sha256-3jqZ4x2ifvlFI7OcUye+pJ7wdPGcEo1z2PzcWR4xrkU=";
})

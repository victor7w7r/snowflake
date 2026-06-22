{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "tui-slides";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "Chleba";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-nQwKrQXm+NAdaAAAfLIfAuJJuQMh5niaelv1rzvApQo=";
  };

  cargoHash = "sha256-3jAA4x2ifvlFI7OcUye+pJ7wdPGcEo1z2PzcWR4xrkU=";
})

{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "gof-rs";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "omagdy7";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-w6JJKYABoJNhfLocbLe7AAAeJv9mzbnzQUD7x30e3SI=";
  };

  cargoHash = "sha256-1kVGOyxIbQmZA2NGih6mN505RAAAEmDrlymAtsrcQLU=";
})

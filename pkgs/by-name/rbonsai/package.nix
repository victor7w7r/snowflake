{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "rbonsai";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "roberte777";
    repo = attrs.pname;
    rev = "main";
    sha256 = "sha256-69MArXaMZLchKURM0koLACKWhm3NO+ZVoZsiHt9PkjQ=";
  };

  cargoHash = "sha256-78vOnu5RZgIR71x8fXbWmoeRDzRgaZBQXJ6nugLNij0=";
})

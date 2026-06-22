{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "kyun";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "lennart-finke";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-8u7HWBL7wUI+Po1RY5FidAj1VEN+grEPIzqfgvSiZ6U=";
  };

  cargoHash = "sha256-Mqv3iPdbC1UElVtQynBeEaZfNJaIr2sFs3IYCB/SQ/c=";
})

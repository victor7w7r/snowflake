{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "texoxide";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "arxari-archive";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wB/ojnWwLwsbPoRMEWqwCiUwsHeURWbONetUW8uRLQA=";
  };

  cargoHash = "sha256-aM1wQbKZsYb644rDqg6cnFwcigT/xU4in+YzDLf2K5o=";
})

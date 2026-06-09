{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "texoxide";
  version = "main";

  src = fetchFromGitHub {
    owner = "arxari-archive";
    repo = pname;
    rev = version;
    sha256 = "sha256-wB/ojnWwLwsbPoRMEWqwCiUwsHeURWbONetUW8uRLQA=";
  };
  cargoHash = "sha256-aM1wQbKZsYb644rDqg6cnFwcigT/xU4in+YzDLf2K5o=";

  nativeBuildInputs = [ pkg-config ];
}

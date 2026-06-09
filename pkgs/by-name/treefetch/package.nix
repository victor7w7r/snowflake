{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "treefetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "angelofallars";
    repo = pname;
    rev = version;
    sha256 = "sha256-FDiulTit492KwV46A3qwjHQwzpjVJvIXTfTrMufXd5k=";
  };
  cargoHash = "sha256-cbJ3Xr9oxMTfEtjcqeFL8c76p8bMMf3lbcdGU3cGvRA=";

  nativeBuildInputs = [ pkg-config ];
}

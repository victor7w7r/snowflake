{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "treefetch";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "angelofallars";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FDiulTit492KwV46A3qwjHQwzpjVJvIXTfTrMufXd5k=";
  };
  cargoHash = "sha256-cbJ3Xr9oxMTfEtjcqeFL8c76p8bMMf3lbcdGU3cGvRA=";

  nativeBuildInputs = with pkgs; [ pkg-config ];
})

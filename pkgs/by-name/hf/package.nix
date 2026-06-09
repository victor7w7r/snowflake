{
  pkg-config,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "hf";
  version = "develop";

  src = fetchFromGitHub {
    owner = "sorairolake";
    repo = pname;
    rev = version;
    sha256 = "sha256-W7KCoJ/uMQKrh6r4K/Ln/9sfQKa/+Rxe6zz6Xa5ZPak=";
  };

  cargoHash = "sha256-8rKEQVlxeGkvF61dbFmugfPdee7HlWQMFY9IWwBH6xQ=";

  nativeBuildInputs = [ pkg-config ];
}

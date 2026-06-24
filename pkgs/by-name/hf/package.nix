{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "hf";
  version = "develop";

  src = pkgs.fetchFromGitHub {
    owner = "sorairolake";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-W7KCoJ/uMQKrh6r4K/Ln/9sfQKa/+Rxe6zz6Xa5ZPak=";
  };

  cargoHash = "sha256-8rKEQVlxeGkvF61dbFmugfPdee7HlWQMFY9IWwBH6xQ=";
})

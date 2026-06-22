{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "gof-rs";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "omagdy7";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-wpJFIcAzg5uAglm161rsHz8tuz2hOYFSG6zfnyN3JLQ=";
  };

  cargoHash = "sha256-yo6pKVGMPHipV5xXco/Kh0IHexWL7RKc1NslNk7qRzc=";
})

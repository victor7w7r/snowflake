{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "socktop";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "jasonwitty";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Kah/xq8s45TsrvFq3fvuo05Bkbi/eSr5aG+kbRM4M6M=";
  };

  cargoHash = "sha256-usaBZ5xIPYKU4Qca8fI8Bg+XcsDUQNiQDdoohXvtu6w=";
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ libdrm ];
})

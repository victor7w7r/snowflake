{
  rustBuild,
  inputs,
  pkgs,
}:
(rustBuild {
  inherit pkgs;
  pname = "socktop";
  src = inputs.socktop;
  version = "0.1.0";
  cargoHash = "sha256-yYvA9EreZn4P/NOEanLHzA8sO5cF5xUYIQgm6M0IfIw=";
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ libdrm ];
})

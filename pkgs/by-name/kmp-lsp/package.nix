{
  rustBuild,
  inputs,
  pkgs,
}:
(rustBuild {
  inherit pkgs;
  cargoHash = "sha256-yo6pKVGMPpaaV5xXco/Kh0IHexWL7RKc1NslNk7qRzc=";
  pname = "kmp-lsp";
  src = inputs.kmp-lsp;
})

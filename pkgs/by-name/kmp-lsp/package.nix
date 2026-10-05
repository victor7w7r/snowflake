{
  rustBuild,
  inputs,
  pkgs,
}:
(rustBuild {
  inherit pkgs;
  cargoHash = "sha256-GGkb8KWc2ZicSOKMErS+a97PT983weioDyE79HRxa4I=";
  pname = "kmp-lsp";
  src = inputs.kmp-lsp;
})

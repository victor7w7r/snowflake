{
  rustBuild,
  inputs,
  pkgs,
}:
(rustBuild {
  inherit pkgs;
  pname = "hf";
  cargoHash = "sha256-PwU7x6vwi3ULMtwX9hS07/4PefpugaR5VKihBvVtQgc=";
  src = inputs.hf;
})

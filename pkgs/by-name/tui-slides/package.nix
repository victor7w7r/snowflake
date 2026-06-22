{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "tui-slides";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "Chleba";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-w6JJKYABoJNhfLocbLe7CGZeJv9mzbnzQUD7x30e3SI=";
  };

  env = {
    NIX_CFLAGS_COMPILE = "-std=gnu89 -Wno-error=incompatible-pointer-types";
  };

  cargoHash = "sha256-1kVGOyxIbQmZA2NGih6mN505RfKKEmDrlymAtsrcQLU=";
})

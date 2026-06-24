{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "loop";
  version = "unstable-2020-07-08";

  src = pkgs.fetchFromGitHub {
    owner = "Miserlou";
    repo = attrs.pname;
    rev = "944df766ddecd7a0d67d91cc2dfda8c197179fb0";
    sha256 = "0v61kahwk1kdy8pb40rjnzcxby42nh02nyg9jqqpx3vgdrpxlnix";
  };

  cargoHash = "sha256-sceS/2qxiV16VP8E3M39MYnGiCbq0rrnehsV/SuHZl4=";
})

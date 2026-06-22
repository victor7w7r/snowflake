{ pkgs, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "loc";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "cgag";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-GYnXoiYAePf6paExmeDF3XDZ8mSF5hmmXkTvxSpOj+U=";
  };

  cargoHash = "sha256-3ebajlV0ONO2ggMCtfwWLnOlGDi7dx1iL+FpyG8OSI0=";
})

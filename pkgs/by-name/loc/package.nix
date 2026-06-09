{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "loc";
  version = "master";

  src = fetchFromGitHub {
    owner = "cgag";
    repo = pname;
    rev = version;
    sha256 = "sha256-GYnXoiYAePf6paExmeDF3XDZ8mSF5hmmXkTvxSpOj+U=";
  };

  cargoHash = "sha256-3ebajlV0ONO2ggMCtfwWLnOlGDi7dx1iL+FpyG8OSI0=";
}

{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "zilch";
  version = "master";

  src = fetchFromGitHub {
    owner = "lavafroth";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-JLprFZuOlbj36ai2vvSM6VSWYDD1Bn0CRe5dUcXd7yI=";
  };

  cargoHash = "sha256-M3+66AsLgkfpg8sHvx4vWFLKSS9a8soSxjFMDe8ip1o=";
})

{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "scrcpy-wrapper";
  version = "master";

  src = fetchFromGitHub {
    owner = "Bluemangoo";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-JLprFZuOlbj36ai2vAAA6VSWYDD1Bn0CRe5dUcXd7yI=";
  };

  cargoHash = "sha256-M3+66AsLgkfpg8sHvDDDWFLKSS9a8soSxjFMDe8ip1o=";
})

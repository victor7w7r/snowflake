{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "mfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "xdearboy";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-6Alw4OFRdut0fwDsYrkMazbrL1l5VMds+XbhYxWHF28=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  prePatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  cargoHash = "sha256-ywqXUp3X9Jf6O7OdWyyrUPaAJx+IAAvPQU+7nP2okpM=";
})

{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage (attrs: {
  pname = "autoricer";
  version = "main";

  src = fetchFromGitHub {
    owner = "3rfaan";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-8Ff9QhdQ1BrpKN2r81gAGlZGaybCdI2pIl3PQVUaSbU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  prePatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  cargoHash = "sha256-ywqXUp3X9JfAAAOdWyyrUPaAJx+I3cvPQU+7nP2okpM=";
})

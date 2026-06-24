{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage (attrs: {
  pname = "envfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "ankddev";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-NIlc/vxu8Y9bVMx2exosKZAVAcGbQAmOnjGxAHgNis0=";
  };

  doCheck = false;
  cargoHash = "sha256-FPhfhSacdFrWEJg97hyzAbTxKTVkKhIXy4TKOClVOvs=";
})

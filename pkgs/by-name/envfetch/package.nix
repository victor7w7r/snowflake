{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "envfetch";
  version = "main";

  src = fetchFromGitHub {
    owner = "ankddev";
    repo = pname;
    rev = version;
    sha256 = "sha256-NIlc/vxu8Y9bVMx2exosKZAVAcGbQAmOnjGxAHgNis0=";
  };

  doCheck = false;

  cargoHash = "sha256-FPhfhSacdFrWEJg97hyzAbTxKTVkKhIXy4TKOClVOvs=";
}

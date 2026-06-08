{ pkgs, stdenv }:
stdenv.mkDerivation rec {
  pname = "cfiles";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "FoleyBridge-Solutions";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-szDsxkkJRYnQ73iemi/DjArO3Z5kIAEoLoPkToHoRtM=";
  };

  buildInputs = with pkgs; [ glibc ];
  nativeBuildInputs = with pkgs; [ pkg-config ];
  makeFlags = [ "PREFIX=$(out)" ];
  installPhase = "make install";
}

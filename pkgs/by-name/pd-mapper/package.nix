{ cache-stdenv, pkgs }:
cache-stdenv.mkDerivation {
  pname = "pd-mapper";
  version = "unstable-2025-11-03";

  src = pkgs.fetchFromGitHub {
    owner = "linux-msm";
    repo = "pd-mapper";
    rev = "0a43c8be564feae0493b6e24b2e3e98459a4f9b6";
    hash = "sha256-XiEZS+hb44nD1o1Xvjnrq5ead7Nym/Yg7iCnr93qC+k=";
  };

  buildInputs = with pkgs; [
    qrtr
    xz
  ];

  installFlags = [ "prefix=$(out)" ];
}

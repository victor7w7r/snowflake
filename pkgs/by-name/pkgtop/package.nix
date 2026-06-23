{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "pkgtop";
  version = "master";

  src = fetchFromGitHub {
    owner = "orhun";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-O1kE2LkIKxzgo8+gAirEhxrhLFkda3lNybeE0w7ajRA=";
  };

  vendorHash = "sha256-dlDbNym7CNn5088znMNgGAr2wBM3+nYv3q362353aLs=";

  ldflags = [
    "-s"
    "-w"
  ];
})

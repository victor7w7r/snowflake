{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "corrupter";
  version = "master";

  src = fetchFromGitHub {
    owner = "r00tman";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-GEia3wZqI/j7/dpBbL1SQLkOXZqEwanKGM4wY9nLIqE=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];
})

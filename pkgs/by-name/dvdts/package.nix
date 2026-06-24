{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "dvdts";
  version = "master";

  src = fetchFromGitHub {
    owner = "ForumPlayer";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-M8H1oBW89Cy54Iktso4WdXyqsppw1pznziKD+g7teWU=";
  };

  vendorHash = "sha256-zEuzEGx8CVk/EeW+DCOg3C8k/SK0V3dnVdEpeFp422w=";

  ldflags = [
    "-s"
    "-w"
  ];
})

{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "spotitube";
  version = "master";

  src = fetchFromGitHub {
    owner = "streambinder";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-SVgtAQa+frRO7r6CRKv0ZF2yciqjxuJl/Qobn6YdDi0=";
  };

  doCheck = false;
  vendorHash = "sha256-DIhA+QaHgwoJxUcZI+SVxZr31hIsWJ2zyMFThmiO1JE=";

  ldflags = [
    "-s"
    "-w"
  ];
})

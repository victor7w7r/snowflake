{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "hypr-zoom";
  version = "main";

  src = fetchFromGitHub {
    owner = "icyleaf";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-54CTCPmt8l/vex5Z3LnAAAzrOhaHWZG/jOZ5O2AkEwM=";
  };

  vendorHash = "sha256-/YbDLiXRx6C/AAApOEvzFFuXTNroreAOa97FblGs0A8=";

  ldflags = [
    "-s"
    "-w"
  ];
})

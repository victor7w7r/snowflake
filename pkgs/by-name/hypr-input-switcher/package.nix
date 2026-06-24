{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "hypr-input-switcher";
  version = "main";

  src = fetchFromGitHub {
    owner = "icyleaf";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-54CTCPmt8l/vex5Z3Ln01TzrOhaHWZG/jOZ5O2AkEwM=";
  };

  vendorHash = "sha256-/YbDLiXRx6C/Kl8pOEvzFFuXTNroreAOa97FblGs0A8=";

  ldflags = [
    "-s"
    "-w"
  ];
})

{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "Kat-OH";
  version = "main";

  src = fetchFromGitHub {
    owner = "aryvector";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-iODqdDC1kEPzFVD2k5WqaQb/nIrJmZWZbcSIn/ewHxY=";
  };

  vendorHash = "sha256-ArqQ2YPhcb3sRx349ZBsmo4YxxHtgYkh4A4BWZw3aAQ=";

  ldflags = [
    "-s"
    "-w"
  ];
})

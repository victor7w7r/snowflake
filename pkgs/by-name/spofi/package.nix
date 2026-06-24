{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "spofi";
  version = "main";

  src = fetchFromGitHub {
    owner = "davidborzek";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QcE2kUP36LnwA1NXsBKJj1/AAAKvzdB7/37GcWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTAAdqwp8btyw+uw2lhexx8NrvHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

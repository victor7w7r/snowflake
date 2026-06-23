{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "Kat-OH";
  version = "main";

  src = fetchFromGitHub {
    owner = "aryvector";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QcE2kUP36LnwA1NXAAAJj1/CgwKvzdB7/37GcWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTsndqwp8btAA+uw2lhexx8NrvHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

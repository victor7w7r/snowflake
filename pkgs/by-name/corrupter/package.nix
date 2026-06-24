{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "corrupter";
  version = "master";

  src = fetchFromGitHub {
    owner = "r00tman";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QcE2kUP36LnwA1NXsBKAAA/CgwKvzdB7/37GcWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTsndqwp8btyw+uwAAAexx8NrvHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

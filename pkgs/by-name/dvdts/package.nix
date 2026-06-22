{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "dvdts";
  version = "master";

  src = fetchFromGitHub {
    owner = "ForumPlayer";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QcE2kUP36LnwA1NXsBKJj1/CgwKvzdB7/3AAAWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTsndqwp8btyw+uw2lhexx8NAAHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "hypr-input-switcher";
  version = "main";

  src = fetchFromGitHub {
    owner = "icyleaf";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-QcE2kUP36LnwA1AAABKJj1/CgwKvzdB7/37GcWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTsndqAA8btyw+uw2lhexx8NrvHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

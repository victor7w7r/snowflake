{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "go-life";
  version = "master";

  src = fetchFromGitHub {
    owner = "sachaos";
    repo = pname;
    rev = version;
    sha256 = "sha256-QcE2kUP36LnwA1NXsBKJj1/CgwKvzdB7/37GcWTrVGs=";
  };

  vendorHash = "sha256-/VM+CZSGTObZGTsndqwp8btyw+uw2lhexx8NrvHazB4=";

  ldflags = [
    "-s"
    "-w"
  ];
}

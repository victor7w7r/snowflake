{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "mynav";
  version = "main";

  src = fetchFromGitHub {
    owner = "GianlucaP106";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-mFpeJCF44hddoJNrU2pidm/8xSXEjMPguBEarlGdXDU=";
  };

  vendorHash = "sha256-EtPGBSW0deqRXO5iQjdgcySbvLSHa1gs25OBlImWWSM=";

  ldflags = [
    "-s"
    "-w"
  ];
})

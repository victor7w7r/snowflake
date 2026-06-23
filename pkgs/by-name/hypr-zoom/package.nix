{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "hypr-zoom";
  version = "main";

  src = fetchFromGitHub {
    owner = "FShou";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-/5nC4iLcDJ+UODLpzuVitQTFdBZtz75ep73RSN37hHE=";
  };

  vendorHash = "sha256-BCx2hKi6U/MPJlwAmnM4/stiolhYkakpe4EN3e5r6L4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

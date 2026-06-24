{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "gspot";
  version = "master";

  src = fetchFromGitHub {
    owner = "abs3ntdev";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-/4P6x/zQz1voOavpWdT6f9JCZQpMlX/QTQUXhftYsus=";
  };
  vendorHash = "sha256-HbPPGSL2qfGDYAoyoaPaFK4Urngtc87OWEuHPGtqqYU=";

  ldflags = [
    "-s"
    "-w"
  ];
})

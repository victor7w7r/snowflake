{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "pkgtop";
  version = "master";

  src = fetchFromGitHub {
    owner = "orhun";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KqZGwicWCi+9TLF4AAAAAL/Kz5C2a9iXAtcQYaswpWo=";
  };

  vendorHash = "sha256-xWOPiSX2cEmekd2k96O8AAn3ygW1nU1MU4qL+JJN0AE=";

  ldflags = [
    "-s"
    "-w"
  ];
})

{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "mabel";
  version = "master";

  src = fetchFromGitHub {
    owner = "smmr-software";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KqZGwicWCi+9TLF4AwD3zL/Kz5C2a9iXAtcQYaswpWo=";
  };

  CGO_CFLAGS = "-std=gnu89 -fpermissive";
  vendorHash = "sha256-xWOPiSX2cEmekd2k96O81qn3ygW1nU1MU4qL+JJN0AE=";

  ldflags = [
    "-s"
    "-w"
  ];
})

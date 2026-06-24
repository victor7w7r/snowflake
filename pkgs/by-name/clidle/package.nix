{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "clidle";
  version = "main";

  src = fetchFromGitHub {
    owner = "ajeetdsouza";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-KgIJM7yswNk+LgHxoUp6uRR8a2VD5p8Bq8uMgyJFcKE=";
  };

  vendorHash = "sha256-vevil9MxPr3YcB7m1Jzvypioq6aOkWrQeFCC1fPeQKw=";

  ldflags = [
    "-s"
    "-w"
  ];
})

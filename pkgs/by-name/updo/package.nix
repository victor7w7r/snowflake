{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "updo";
  version = "main";

  src = fetchFromGitHub {
    owner = "Owloops";
    repo = pname;
    rev = version;
    sha256 = "sha256-2+h7lptHqmFrbji045v5TjkFEmT4RxefFpBX/YzNTR8=";
  };

  vendorHash = "sha256-I5Cu0cXNsPoVBgouE+hRn/s1x2IbRt+V6kHDcfiRIfA=";
  subPackages = [
    "cmd/aws"
    "cmd/monitor"
    "cmd/root"
  ];
  ldflags = [
    "-s"
    "-w"
  ];
}

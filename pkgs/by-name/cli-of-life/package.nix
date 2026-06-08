{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "cli-of-life";
  version = "main";

  src = fetchFromGitHub {
    owner = "gabe565";
    repo = pname;
    rev = version;
    sha256 = lib.fakeSha256;
  };

  vendorHash = lib.fakeHash;

  ldflags = [
    "-s"
    "-w"
  ];
}

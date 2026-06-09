{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "fman";
  version = "main";

  src = fetchFromGitHub {
    owner = "nore-dev";
    repo = pname;
    rev = version;
    sha256 = "sha256-NgN94cJRmS0YziIGCeEzzw9p7lPNnpyiRyF+ZcMYCDc=";
  };
  vendorHash = "sha256-ZfU6KvChsTWu6wGOb9/vq6Bk/AGheZiGNlxh5on3W7Q=";

  ldflags = [
    "-s"
    "-w"
  ];
}

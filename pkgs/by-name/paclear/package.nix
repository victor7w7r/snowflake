{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "paclear";
  version = "main";

  src = fetchFromGitHub {
    owner = "orangekame3";
    repo = pname;
    rev = version;
    sha256 = "sha256-Q4uY5aEcQKKLxhBGzmLdOy/bLG0/hpFRkF10wA68Ic0=";
  };

  vendorHash = "sha256-VE3nnUO3A/HkaoGXef+zuPT2VubWiDfiiSils0F0l74=";

  ldflags = [
    "-s"
    "-w"
  ];
}

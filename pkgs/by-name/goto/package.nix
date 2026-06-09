{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "goto";
  version = "develop";

  src = fetchFromGitHub {
    owner = "grafviktor";
    repo = pname;
    rev = version;
    sha256 = "sha256-Bw+GjwEWt0vZDJWb3WpO3fBDTZR2IVAhiYqsMSVLFbk=";
  };

  vendorHash = "sha256-vED3QySeVRtk0ZeFSXpnQuCThsiNkVW6sNpJbrE8JV4=";

  ldflags = [
    "-s"
    "-w"
  ];
}

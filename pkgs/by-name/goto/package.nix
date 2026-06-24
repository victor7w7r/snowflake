{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "goto";
  version = "develop";

  src = fetchFromGitHub {
    owner = "grafviktor";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-SG9WhTKlnROwLCa63c2TYm4rnhCpr0hEkl1jJNDqxWk=";
  };

  vendorHash = "sha256-vED3QySeVRtk0ZeFSXpnQuCThsiNkVW6sNpJbrE8JV4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

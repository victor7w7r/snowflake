{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "streambinder";
  version = "master";

  src = fetchFromGitHub {
    owner = "spotitube";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-SG9WhTKlnROwLCa63c2TYm4rAAApr0hEkl1jJNDqxWk=";
  };

  vendorHash = "sha256-vED3QySeVRtkAAAFSXpnQuCThsiNkVW6sNpJbrE8JV4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

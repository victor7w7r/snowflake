{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "lazysys";
  version = "main";

  src = fetchFromGitHub {
    owner = "XhuyZ";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Kah/xq8s45TsrvAAAfvuo05Bkbi/eSr5aG+kbRM4M6M=";
  };

  vendorHash = "sha256-vED3QySeVRtk0ZeFAAAnQuCThsiNkVW6sNpJbrE8JV4=";

  ldflags = [
    "-s"
    "-w"
  ];
})

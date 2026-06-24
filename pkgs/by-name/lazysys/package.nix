{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "lazysys";
  version = "main";

  src = fetchFromGitHub {
    owner = "XhuyZ";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-8n4m72ERDZQDPFMBMrAKWMYxFs9kGd71dZPB7OcIOq0=";
  };

  vendorHash = "sha256-17DJNut4otpI1DV42P1XvPe8Ny+E7ETsfyNXRkknS/A=";

  ldflags = [
    "-s"
    "-w"
  ];
})

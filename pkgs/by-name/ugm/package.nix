{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "ugm";
  version = "main";

  src = fetchFromGitHub {
    owner = "ariasmn";
    repo = pname;
    rev = version;
    sha256 = "sha256-W4oHJAEppb17t1kxKxDF5fVZkqhOtvm7gCtlmSg7YFA=";
  };

  vendorHash = "sha256-W9v52cxhXdNyW5RGk+SoA1u7Yid+63YYdd9YaGKEWDs=";

  ldflags = [
    "-s"
    "-w"
  ];
}

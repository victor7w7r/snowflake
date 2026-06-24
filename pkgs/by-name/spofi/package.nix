{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "spofi";
  version = "main";

  src = fetchFromGitHub {
    owner = "davidborzek";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Fxs/a/Zk3orMYbT3noxWbub7wOtiwZFhbpbgGW7UUgI=";
  };

  vendorHash = "sha256-1P4lj91WYNK5wE+c9AQsKhdJPgP3oBJjv2cw1mtJ528=";

  ldflags = [
    "-s"
    "-w"
  ];
})

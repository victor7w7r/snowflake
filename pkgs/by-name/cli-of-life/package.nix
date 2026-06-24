{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "cli-of-life";
  version = "main";

  src = fetchFromGitHub {
    owner = "gabe565";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-dHP2qil9LQmSVBXblDjE4y9lrwR9iXEewRzqTG8CFh0=";
  };

  vendorHash = "sha256-ZueGOJ7UoeixttPP/eTzChBtCDeySQw70CdBHv5zYgo=";

  ldflags = [
    "-s"
    "-w"
  ];
})

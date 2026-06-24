{ buildGoModule, fetchFromGitHub }:
buildGoModule (attrs: {
  pname = "cemetery-escape";
  version = "main";

  src = fetchFromGitHub {
    owner = "tom-on-the-internet";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-7oTeknoFxnMhs6RSswTxF+P7dgSTsJ9O8QG2ZjmgZNg=";
  };

  vendorHash = "sha256-/yOpyvbt+H7AQLXn2gp+6JRaLTDR3hBznOq5L1DUUUQ=";

  ldflags = [
    "-s"
    "-w"
  ];
})

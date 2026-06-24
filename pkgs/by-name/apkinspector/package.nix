{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "apkInspector";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "erev0s";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-6efXoiyjTEzadZ5aut4lFbjth03Uyw8REIYQYjvWS/c=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
    poetry-core
  ];
})

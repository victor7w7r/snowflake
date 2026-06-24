{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "procmux";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "napisani";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Yx1S8JMOUhFTX3kB6Y3PqAw27qClkcUvtzrIuj5etZo=";
  };

  build-system = with python3.pkgs; [
    setuptools
    hatchling
  ];

  dependencies = with python3.pkgs; [
    hiyapyco
    prompt-toolkit
    #ptterm
    #pyte
    pytest
  ];
})

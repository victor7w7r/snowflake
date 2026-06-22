{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "termsaver";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "brunobraga";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQAAAlcJyT0CGP4dyo766CJUg+10MGFPeU=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [

  ];
})

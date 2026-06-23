{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "osu-cli";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kartavkun";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQFLPlcJAT0CGP4Ayo766CJUg+10MGFPeU=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    ossapi
    colorama
    httpx
  ];
})

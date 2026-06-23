{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "better-adb-sync";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jb2170";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQFAAlcJyT0CGP4dyo766CJUg+10MGFPeU=";
  };

  dontCheckRuntimeDeps = true;

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [

  ];
})

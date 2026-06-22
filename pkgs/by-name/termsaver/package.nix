{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "termsaver";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "brunobraga";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Q8reLENrR4BRHl1AxapotflL9mheLVp8fRn0v0hheQc=";
  };

  nativeBuildInputs = with python3.pkgs; [
    pdm-backend
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pip
  ];

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    pillow
    requests
  ];
})

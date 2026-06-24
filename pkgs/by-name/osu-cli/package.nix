{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "osu-cli";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kartavkun";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-3v0SiOmBhtxTMLlGnWiDWWz9gRBf6YcCBqC47aELoRI=";
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

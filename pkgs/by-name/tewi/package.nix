{ pkgs, fetchFromGitHub }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "tewi";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "anlar";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Twhr9+gGb+3d91JAAACUCPtSdOfcLZAq4jvH6llQ9no=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
  ];

  build-system = with pkgs.python3.pkgs; [
    hatchling
    setuptools
  ];
})

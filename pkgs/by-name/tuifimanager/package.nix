{ pkgs, fetchFromGitHub }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "TUIFIManager";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "GiorgosXou";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-doKDB+UU9dxPGHWhM8LYIrn+OHkpKmD+lnCvqbN60Yc=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    unicurses
    send2trash
  ];

  build-system = with pkgs.python3.pkgs; [
    hatchling
    setuptools
    setuptools-scm
  ];
})

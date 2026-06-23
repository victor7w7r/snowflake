{ pkgs, fetchFromGitHub }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "endcord";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sparklost";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-tqXHEyhQB0064dJAAAANSThfouEn9KLCbEFs1cFe+qM=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
  ];

  build-system = with pkgs.python3.pkgs; [
    hatchling
    setuptools
  ];
})

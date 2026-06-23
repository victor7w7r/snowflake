{ pkgs }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "adb_shell";
  version = "master";
  format = "setuptools";

  src = pkgs.fetchFromGitHub {
    owner = "JeffLIrion";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-3PJculwZ8L7YwS7Hw3RAAAx9mL5Q0M6YhiUWELtDUk8=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
  ];
})

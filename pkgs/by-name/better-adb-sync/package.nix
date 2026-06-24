{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "better-adb-sync";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jb2170";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-ghOpcnQEZiAEZOiVWhrHa66WgiyyYQZgTJEokJFKMRs=";
  };

  dontCheckRuntimeDeps = true;

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];
})

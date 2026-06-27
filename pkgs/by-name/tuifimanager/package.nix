{ pkgs, fetchFromGitHub }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "TUIFIManager";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "GiorgosXou";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-31/8X0bTw3P/PkI66UB3Pt6xa2oFwBQ1OSeY4rGyAvo=";
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

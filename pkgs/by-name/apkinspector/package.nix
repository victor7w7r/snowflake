{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "apkInspector";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "erev0s";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQFLPlcJyT0CGAAAyo766CJUg+10MGFPeU=";
  };

  dontCheckRuntimeDeps = true;

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    aiosqlite
    click
    click-default-group
    humanize
    google-generativeai
    greenlet
    litellm
    networkx
    pyperclip
    sqlmodel
    textual
    tree-sitter
    xdg-base-dirs
  ];
})

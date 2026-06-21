{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "elia";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "darrenburns";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQFLPlcJyT0CGP4dyo766CJUg+10MGFPeU=";
  };

  dontCheckRuntimeDeps = true;

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace "textual==0.79.1" "textual"
  '';

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

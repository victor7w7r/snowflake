{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "TUIFIManager";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "GiorgosXou";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FCdY2mS80ZQFLPlcJyAAAGP4dyo766CJUg+10MGFPeU=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    file-manager
  ];
})

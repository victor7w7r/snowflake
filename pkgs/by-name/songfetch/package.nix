{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "songfetch";
  version = "main";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ekrlstd";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-1ZCCfZjTHtmv7ZdmsCZbKiYYo88Wh8wrTXOEhXHawUo=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    ascii-magic
    pillow
  ];
})

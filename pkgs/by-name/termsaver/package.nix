{ inputs, python3 }:
python3.pkgs.buildPythonApplication {
  pname = "termsaver";
  version = "latest";
  pyproject = true;
  src = inputs.termsaver;

  postPatch = ''
    substituteInPlace termsaver/termsaverlib/screen/base/__init__.py \
      --replace-fail "reqs = subprocess.check_output([sys.executable, '-m', 'pip', 'freeze'])" 'reqs = b""'
  '';

  nativeBuildInputs = with python3.pkgs; [
    pdm-backend
  ];

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];

  dependencies = with python3.pkgs; [
    pillow
    requests
  ];
}

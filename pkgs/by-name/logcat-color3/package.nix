{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "logcat-color3";
  version = "0.10.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "yan12125";
    repo = attrs.pname;
    rev = "master";
    sha256 = "sha256-p/rh5I5kLW9QAPXgRiwhwLEeFydNq+q/3XrK2yL88js=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
    setuptools-scm
  ];

  dependencies = with python3.pkgs; [
    colorama
    pyasyncore
    pyasynchat
  ];

})

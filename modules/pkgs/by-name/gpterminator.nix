{ pkgs, python3Packages }:
python3Packages.buildPythonApplication {
  pname = "gpterminator";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/3b/08/8b77b43c4fc6da2ad3aab16a3f22c1bdd28bdf9fdd2b9d01dbd99f8c23bf/gpterminator-0.1.11.tar.gz";
    sha256 = "sha256-2gvm0hOLYgmONH/QnG8xDTveh3RXp3dP5ganxBNaOA4=";
  };

  doCheck = false;
  format = "setuptools";

  propagatedBuildInputs = with python3Packages; [
    setuptoolskB
    requests
  ];
}

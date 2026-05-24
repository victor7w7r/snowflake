{ pkgs, python3Packages }:
python3Packages.buildPythonApplication {
  pname = "elia-chat";
  version = "1.10.0";

  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/2b/fc/7b4ae37fa37831d1f4aaa778f41e3d8801038190b83115473ec68c8634d9/elia_chat-1.10.0.tar.gz";
    sha256 = "sha256-u8s1/AVrYR3O3yLUX2Je6in8H3mhukFFNCL35idObdg=";
  };

  doCheck = false;
  format = "setuptools";

  propagatedBuildInputs = with python3Packages; [
    setuptools
    requests
  ];
}

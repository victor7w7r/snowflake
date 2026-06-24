{ pkgs }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "rofi-tmux";
  version = "master";
  format = "setuptools";

  src = pkgs.fetchFromGitHub {
    owner = "viniarck";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-TlQm6hQSvuBvaVq3jsPPxFAGbIE7di3H7VihgoStUBg=";
  };

  propagatedBuildInputs = with pkgs.python3.pkgs; [
    click
    i3ipc
    libtmux
  ];
})

{ pkgs }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "rofi-tmux";
  version = "master";
  format = "setuptools";

  src = pkgs.fetchFromGitHub {
    owner = "viniarck";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-8Vqd3N87WyfvE2qt+CLaKAAA/rWGNAObaI8LOzV3yAk=";
  };
})

{ python3, fetchFromGitHub }:
python3.pkgs.buildPythonApplication (attrs: {
  pname = "logcat-color3";
  version = "master";

  src = fetchFromGitHub {
    owner = "yan12125";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-GYnXoiYAePfAAaExmeDF3XDZ8mSF5hmmXkTvxSpOj+U=";
  };

  build-system = with python3.pkgs; [
    hatchling
    setuptools
  ];
})

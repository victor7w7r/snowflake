{ pkgs, fetchFromGitHub }:
let
  geoip2fast = pkgs.python3Packages.buildPythonPackage rec {
    pname = "geoip2fast";
    version = "1.2.2";
    pyproject = true;

    src = pkgs.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "sha256-OIFXAM7f6xl9UbS4czsNT3lls23hUUfBJVJxJPi0XWs=";
    };

    nativeBuildInputs = with pkgs.python3Packages; [
      setuptools
      wheel
    ];
    doCheck = false;
  };
in
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "tewi";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "anlar";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-FDzZzUAlgmKP5dhL9SsAhKY/z/PYu/4uE9hEmYqd9i4=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    textual
    transmission-rpc
    geoip2fast
    pyperclip
    qbittorrent-api
    platformdirs
  ];

  build-system = with pkgs.python3.pkgs; [
    hatchling
    setuptools
  ];
})

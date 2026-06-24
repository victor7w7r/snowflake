{ pkgs, fetchFromGitHub }:
pkgs.python3.pkgs.buildPythonApplication (attrs: {
  pname = "endcord";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sparklost";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Twhr9+gGb+3d91JGU2CUCPtSdOfcLZAq4jvH6llQ9no=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    filetype
    numpy
    orjson
    pycryptodome
    pysocks
    soundcard
    soundfile
    websocket-client
  ];

  postPatch = ''
    if [ -f pyproject.toml ]; then
      substituteInPlace pyproject.toml \
        --replace "numpy>=2.4.6" "numpy>=2.4.4" \
        --replace "orjson>=3.11.9" "orjson>=3.11.7" \
        --replace "soundfile>=0.14.0" "soundfile>=0.13.1"
    fi
  '';

  build-system = with pkgs.python3.pkgs; [
    hatchling
    setuptools
    cython
  ];
})

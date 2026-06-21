{
  autoconf,
  automake,
  fetchFromGitHub,
  pkg-config,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "ext4-crypt";
  version = "master";

  src = fetchFromGitHub {
    owner = "gdelugre";
    repo = pname;
    rev = version;
    sha256 = "sha256-wqXCmm2CAp+AANWMsK17lW9PdFqVPBh+N156qivDdC0=";
  };

  nativeBuildInputs = [
    pkg-config
    autoconf
    automake
  ];

  makeFlags = [ "PREFIX=$(out)" ];
}

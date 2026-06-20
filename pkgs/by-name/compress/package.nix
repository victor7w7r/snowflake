{
  python3,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "compress";
  version = "master";

  src = fetchFromGitHub {
    owner = "benapetr";
    repo = pname;
    rev = version;
    sha256 = "sha256-Yx1S8JMOUhFTX3kAAA3PqAw27qClkcUvtzrIuj5etZo=";
  };

  nativeBuildInputs = with python3.pkgs; [

  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/src/compress $out/bin
  '';
}

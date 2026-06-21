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
    sha256 = "sha256-Q+oCgEXrnqY68f9p5N2ziqrqJAkIxh88wCYXfOZNfvE=";
  };

  nativeBuildInputs = [
    (python3.withPackages (ps: [ ps.pyyaml ]))
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/src/compress $out/bin
    chmod +x $out/bin/compress
    patchShebangs $out/bin/compress
  '';
}

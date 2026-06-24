{ pkgs, stdenvNoCC }:
stdenvNoCC.mkDerivation (attrs: {
  pname = "compress";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "benapetr";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Q+oCgEXrnqY68f9p5N2ziqrqJAkIxh88wCYXfOZNfvE=";
  };

  nativeBuildInputs = with pkgs; [
    (python3.withPackages (ps: [ ps.pyyaml ]))
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/src/compress $out/bin
    chmod +x $out/bin/compress
    patchShebangs $out/bin/compress
  '';
})

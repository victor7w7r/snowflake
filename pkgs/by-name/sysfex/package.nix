{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "sysfex";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "mehedirm6244";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-Y6hCLQJZmfm2yYIcyy20nLxrYb/8+bj8l7CD6ksTqc4=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    makeWrapper
  ];

  buildInputs = with pkgs; [ icu ];

  installPhase = ''
    mkdir -p $out/bin
    if [ -f "sysfex" ]; then
      cp sysfex $out/bin/
    else
      cp bin/sysfex $out/bin/ || find . -name sysfex -exec cp {} $out/bin/ \;
    fi

    wrapProgram $out/bin/sysfex \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.pciutils ]}
  '';
})

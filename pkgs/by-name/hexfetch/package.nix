{ pkgs, stdenv }:

stdenv.mkDerivation (attrs: {
  pname = "hexfetch";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "hexisXz";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-B0X79u+ImHjLhb45fLUzjMF0abrVIVRy0UxiMLFI5vE=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];

  buildInputs = with pkgs; [
    lsb-release
    figlet
  ];

  buildPhase = ''
    cd src
    gcc hexfetch.c -o hexfetch
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp hexfetch $out/bin/
    wrapProgram $out/bin/hexfetch \
      --prefix PATH : ${
        pkgs.lib.makeBinPath [
          pkgs.lsb-release
          pkgs.figlet
        ]
      }
  '';
})

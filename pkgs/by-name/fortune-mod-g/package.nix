{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "gfortune";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Ev1lbl0w";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-IoD7M+1CuaKB06Ku/AAAEiRcAIr5bYdfEu8xeFuPaNo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    caesar 13 < gsource > g
    strfile -x g g.dat
    install -Dvm644 g g.dat -- billwurtz billwurtz.dat "$out/share/fortune"
  '';
})

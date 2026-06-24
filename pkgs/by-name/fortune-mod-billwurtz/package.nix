{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-billwurtz";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Ev1lbl0w";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-IoD7M+1CuaKB06Ku/ddwEiRcAIr5bYdfEu8xeFuPaNo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/games/fortunes"
    install -m644 -- billwurtz billwurtz.dat "$out/share/games/fortunes"
  '';
})

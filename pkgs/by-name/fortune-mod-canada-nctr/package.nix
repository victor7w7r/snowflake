{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-canada-nctr";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "mikebirdgeneau";
    repo = attrs.pname;
    rev = attrs.version;
    sha256 = "sha256-IoD7M+1CuaKB0AAA/ddwEiRcAIr5bYdfEu8xeFuPaNo=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- nctr nctr.dat "$out/share/fortune"
  '';
})

{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-issa-haiku";
  version = "latest";

  src = pkgs.fetchurl {
    url = "http://www.tastyrabbit.net/issa-haiku.tar.gz";
    sha256 = "sha256-f7GqSE6FBpfrke4Pnv56fjy/eqvBAeBvDCBXekwmEnc=";
  };

  nativeBuildInputs = with pkgs; [ fortune ];
  sourceRoot = ".";

  installPhase = ''
    install -dm755 -- "$out/share/fortune"
    install -m644 -- issa-haiku issa-haiku.dat "$out/share/fortune"
  '';
})

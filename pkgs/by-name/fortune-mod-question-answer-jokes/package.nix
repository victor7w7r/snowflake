{ pkgs, stdenv }:
stdenv.mkDerivation (attrs: {
  pname = "fortune-mod-question-answer-jokes";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://billy.wolfe.casa/fortunes/question-answer-jokes";
    sha256 = "sha256-r4wLfUpqqCMZf3775Txvb2PGIcQXSm/YVgMbklfSdBg=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ fortune ];

  installPhase = ''
    cp $src question-answer-jokes
    strfile question-answer-jokes
    install -dm755 -- "$out/share/fortune"
    install -m644 -- question-answer-jokes question-answer-jokes.dat "$out/share/fortune"
  '';
})
